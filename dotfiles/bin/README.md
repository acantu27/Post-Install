# bin

Most of these were made to just save short amounts of time or avoid remembering something specific.

1. `battery_conserve` - manages battery usage by enabling/disabling certain components
    - Add to startup.
    - Requires Gnome.

2. `cda` - equivalent to `cd /dest/dir/ && la`

```bash
cda /dest/dir/

Ouput:
/contents
/of_directory
files
```

3. `cdl` - equivalent to `cd /dest/dir/ && ls`

```bash
cdl /dest/dir/

Ouput:
/contents
/of_directory
files
```

4. `checkdownload` - compares file to the intended SHA256 sum

```bash
checkdownload ubuntu-image-whatever.iso  4bcf82whateversumhere82ab3e

Output:
ubuntu-image-whatever.iso: OK
```

5. `decode` - base64 decode string

```bash
decode aGl0aGVyZXRoaXNpc2F0ZXN0

Output: 
Decoded text copied to clipboard: hitherethisisatest
```

6. `decode_twice` - base64 decode string twice


```bash
decode YUdsMGFHVnlaWFJvYVhOcGMyRjBaWE4w

Output: 
Decoded text copied to clipboard: hitherethisisatest
```

7. `externalip` - display external ip thru http/https/dns

```bash
externalip

Output:
12.23.34.56
```
