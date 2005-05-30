Message-ID: <311fedcf05053020126cdb6e06@...278...>
From: Kelledin <kelledin@...277...>
Reply-To: Kelledin <kelledin@...277...>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_10066_5062798.1117509172266"
Subject: [Openvpn-devel] LZO 2.00 released--compatibility patch attached
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon May 30 20:16:03 2005
To: openvpn-devel@lists.sourceforge.net

------=_Part_10066_5062798.1117509172266
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all, LZO 2.00 was just released, and it has a few API changes.=20
Specifically the worst-case expansion formula prescribed by LZO.FAQ=20
has changed, and headers now get their own lzo/ directory.

The former is probably best fixed by the attached patch.  The latter
is a simple include path check, which I won't bother with--it's pretty
much a no-brainer.  I get by just sticking "-I/usr/include/lzo" in my
CPPFLAGS.

--
Kelledin
"If a server crashes in a server farm and no one pings it, does it
still cost four figures to fix?"

------=_Part_10066_5062798.1117509172266
Content-Type: application/octet-stream; name="openvpn-2.0-lzo2.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="openvpn-2.0-lzo2.patch"

ZGlmZiAtTmF1ciBvcGVudnBuLTIuMC9sem8uaCBvcGVudnBuLTIuMC1sem8yL2x6by5oCi0tLSBv
cGVudnBuLTIuMC9sem8uaAkyMDA1LTA0LTExIDAzOjQzOjU1LjAwMDAwMDAwMCArMDAwMAorKysg
b3BlbnZwbi0yLjAtbHpvMi9sem8uaAkyMDA1LTA1LTMxIDAxOjU0OjE2LjAwMDAwMDAwMCArMDAw
MApAQCAtNDQsNyArNDQsMTEgQEAKICNkZWZpbmUgTFpPX1dPUktTUEFDRQlMWk8xWF8xXzE1X01F
TV9DT01QUkVTUwogI2RlZmluZSBMWk9fREVDT01QUkVTUyAgbHpvMXhfZGVjb21wcmVzc19zYWZl
CiAKKyNpZiBMWk9fVkVSU0lPTj49MHgyMDAwCisjZGVmaW5lIExaT19FWFRSQV9CVUZGRVIobGVu
KSAoKGxlbikvMTYgKyA2NCArIDMpCS8qIExaTyB3b3JzdCBjYXNlIHNpemUgZXhwYW5zaW9uLiAq
LworI2Vsc2UKICNkZWZpbmUgTFpPX0VYVFJBX0JVRkZFUihsZW4pICgobGVuKS82NCArIDE2ICsg
MykJLyogTFpPIHdvcnN0IGNhc2Ugc2l6ZSBleHBhbnNpb24uICovCisjZW5kaWYKIAogLyoKICAq
IERvbid0IHRyeSB0byBjb21wcmVzcyBhbnkgcGFja2V0IHNtYWxsZXIgdGhhbiB0aGlzLgo=
------=_Part_10066_5062798.1117509172266--

