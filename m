Message-ID: <002001c39485$2270b9c0$7781cf0a@...120...>
From: "Ng Siak Hooi" <shng@...119...>
MIME-Version: 1.0
Subject: [Openvpn-devel] cipher final failed
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Oct 17 01:14:06 2003
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi all,
    I added one mode to openssl library, called AES-128-HECTR, where the
mode use 128 bits key, and 256 bits block size.
I managed to get it compiled, and run well with following command:

openssl aes-128-hectr -in a -out b -k test
and
openssl aes-128-hectr -d -in b -out c -k test

I have tried a few times, with big files (from 10Mb to 28Mb). and confirmed
that the output file c is identical to a. (using md5sum to verify)
So I should assumed that my implementation should be well.

Now I compiled openvpn with this new openssl library,
(I modified the file crypto.c at line 103, 297, 461 by adding the phase "||
mode==EVP_CIPH_HECTR_MODE")

I managed to start openvpn at both sides.
but when I ping B from A, (similarly ping A from B, A will get the error)
B will get following errors:

95: select returned 1
96: read from UDP returned 148
97: UDP READ from 1.0.0.1:5000:  DATA 34cab7ca f97a40ef c025c5e0 ddc799fc
a8a7fa15 36193882 04cadb4b bad35dc[more...]
98: IP Address OK from 1.0.0.1:5000
99: DECRYPT IV: 36193882 04cadb4b bad35dc0 1e3d8856 78f3b89b 7522e576
91f9d66b 3cdc5910
100: Authenticate/Decrypt packet error: cipher final failed

Appreciate if anyone can let me know what is wrong some where? What is the
possible places go wrong here?
Hope that anyone let me know, so that I can trace it out.

thanks and regards,
SH Ng





