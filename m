MIME-Version: 1.0
Date: Mon, 27 Jun 2011 23:47:37 +0300
Message-ID: <BANLkTin_cAFwkpiRmk+cSUQNfgOiKbWeEg@...278...>
From: Athanasios Douitsis <aduitsis@...277...>
Content-Type: multipart/mixed; boundary=0015173fe4825726b604a6b7a956
Subject: [Openvpn-devel] IPV6_RECVPKTINFO vs. IPV6_PKTINFO
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0015173fe4825726b604a6b7a956
Content-Type: multipart/alternative; boundary=0015173fe4825726af04a6b7a954

--0015173fe4825726af04a6b7a954
Content-Type: text/plain; charset=ISO-8859-1

Dear all,

Trying to compile latest master on snow leopard, I've noticed that
IPV6_RECVPKTINFO is missing from Mac OS X. So here's a tiny little trivial
patch that makes socket.c fallback to IPV6_PKTINFO accordingly.

If what is being done on
http://www.opensource.apple.com/source/network_cmds/network_cmds-307.0.1/rtsol.tproj/rtsol.cis
any indicator, using IPV6_PKTINFO instead of IPV6_RECVPKTINFO in snow
should yield no differences.

Best Regards,
Athanasios

--0015173fe4825726af04a6b7a954
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear all,<br><br>Trying to compile latest master on snow leopard, I&#39;ve =
noticed that IPV6_RECVPKTINFO is missing from Mac OS X. So here&#39;s a tin=
y little trivial patch that makes socket.c fallback to IPV6_PKTINFO accordi=
ngly. <br>
<br>If what is being done on <a href=3D"http://www.opensource.apple.com/sou=
rce/network_cmds/network_cmds-307.0.1/rtsol.tproj/rtsol.c">http://www.opens=
ource.apple.com/source/network_cmds/network_cmds-307.0.1/rtsol.tproj/rtsol.=
c</a> is any indicator, using IPV6_PKTINFO instead of IPV6_RECVPKTINFO in s=
now should yield no differences. <br>
<br>Best Regards,<br>Athanasios<br><br>

--0015173fe4825726af04a6b7a954--

--0015173fe4825726b604a6b7a956
Content-Type: application/octet-stream; name="ipv6_recvpktinfo.patch"
Content-Disposition: attachment; filename="ipv6_recvpktinfo.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gpfwau1k0

RnJvbSA3Y2ExMmY1MzFlOTRhNTc3YWRhNTM1ZDI1Zjk5ODY1ZTM1ZmRiMjU2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBhZHVpdHNpcyA8YWR1aXRzaXNAZ21haWwuY29tPgpEYXRlOiBN
b24sIDI3IEp1biAyMDExIDIzOjIyOjQzICswMzAwClN1YmplY3Q6IFtQQVRDSF0gbWlub3IgY2hh
bmdlIHRvIGhhbmRsZSBhYnNlbnNlIG9mIElQVjZfUkVDVlBLVElORk8gb24gTWFjIE9TIFgKCi0t
LQogc29ja2V0LmMgfCAgICA3ICsrKysrKysKIDEgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvY2tldC5jIGIvc29ja2V0LmMKaW5k
ZXggNmI4NTVjMC4uMTE5MzRhZCAxMDA2NDQKLS0tIGEvc29ja2V0LmMKKysrIGIvc29ja2V0LmMK
QEAgLTg5MCwxMCArODkwLDE3IEBAIGNyZWF0ZV9zb2NrZXRfdWRwNiAoY29uc3QgdW5zaWduZWQg
aW50IGZsYWdzKQogICBlbHNlIGlmIChmbGFncyAmIFNGX1VTRV9JUF9QS1RJTkZPKQogICAgIHsK
ICAgICAgIGludCBwYWQgPSAxOworI2lmZGVmIElQVjZfUkVDVlBLVElORk8KICAgICAgIGlmIChz
ZXRzb2Nrb3B0IChzZCwgSVBQUk9UT19JUFY2LCBJUFY2X1JFQ1ZQS1RJTkZPLAogCQkgICAgICAo
dm9pZCopJnBhZCwgc2l6ZW9mKHBhZCkpIDwgMCkKIAltc2coTV9TT0NLRVJSLCAiVURQOiBmYWls
ZWQgc2V0c29ja29wdCBmb3IgSVBWNl9SRUNWUEtUSU5GTyIpOwogICAgIH0KKyNlbHNlCisgICAg
ICBpZiAoc2V0c29ja29wdCAoc2QsIElQUFJPVE9fSVBWNiwgSVBWNl9QS1RJTkZPLAorCQkgICAg
ICAodm9pZCopJnBhZCwgc2l6ZW9mKHBhZCkpIDwgMCkKKwltc2coTV9TT0NLRVJSLCAiVURQOiBm
YWlsZWQgc2V0c29ja29wdCBmb3IgSVBWNl9SRUNWUEtUSU5GTyIpOworICAgIH0KKyNlbmRpZgog
I2VuZGlmCiAgIHJldHVybiBzZDsKIH0KLS0gCjEuNi4xLjMKCg==
--0015173fe4825726b604a6b7a956--

