'''update.py'''
import sys
import hashlib
from http.client import HTTPSConnection
import json


def update_bucket(version: str) -> None:
    '''simple json loading and dumping'''

    content: dict
    with open('./bucket/crimson.json', encoding='utf8', mode='r') as file:
        content = json.load(file)
        content['version'] = version
        content['url'] = [
            'https://github.com/crimson-crystal/crimson/releases/download/'
            f'{version}/crimson-{version}-windows-x86_64-msvc.zip'
        ]

    with open('./bucket/crimson.json', encoding='utf8', mode='w') as file:
        json.dump(content, file, indent=4)


def update_formula(version: str) -> None:
    '''essentially replaces the line rather than trying to do magic stuff'''

    conn = HTTPSConnection('codeload.github.com')
    conn.request('GET',
                 f'/crimson-crystal/crimson/tar.gz/refs/tags/{version}')

    sha256: str
    with conn.getresponse() as res:
        if res.status != 200:
            print(f'failed to get {version}.tar.gz source '
                  f'(status: {res.status})')
            return

        sha256 = hashlib.sha256(res.read()).hexdigest()

    lines: list
    with open('./Formula/crimson.rb', encoding='utf8', mode='r') as file:
        lines = file.readlines()
        lines[4] = '    url "https://github.com/crimson-crystal/crimson/' \
                   f'archive/refs/tags/{version}.tar.gz"\n'
        lines[5] = f'    sha256 "{sha256}"\n'
        lines[6] = f"    version '{version}'\n"

    with open('./Formula/crimson.rb', encoding='utf8', mode='w') as file:
        file.write(''.join(lines))


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('no version specified')
        sys.exit(1)

    update_bucket(sys.argv[1])
    update_formula(sys.argv[1])
