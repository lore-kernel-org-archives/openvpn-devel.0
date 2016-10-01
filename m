MIME-Version: 1.0
In-Reply-To: <CAA1Abx+1GQKipc1O1D2BXjDgrtDAFTa5GB2GUZKrT+-J-QsuNA@...278...>
References: <1474712639-11698-1-git-send-email-lstipakov@...277...>
	<CAA1Abx+1GQKipc1O1D2BXjDgrtDAFTa5GB2GUZKrT+-J-QsuNA@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 1 Oct 2016 17:05:45 +0300
Message-ID: <CAGyAFMWxUvbth2EevoM1o5nuxOEK+1xZZnoHui+Kwc6AtqmGgg@...278...>
Content-Type: multipart/mixed; boundary=001a1148f5c20e159d053dce3579
Subject: [Openvpn-devel] Fwd:  [PATCH] Fix duplicated PUSH_REPLY options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1148f5c20e159d053dce3579
Content-Type: multipart/alternative; boundary=001a1148f5c20e1595053dce3577

--001a1148f5c20e1595053dce3577
Content-Type: text/plain; charset=UTF-8

Hi,

Attempt #2 - now with attached patch.

ACK from me - tested that peer-id and cipher are not duplicated in
PUSH_REPLY when client reconnects and push-continuation works.

-Lev


---------- Forwarded message ----------
From: Steffan Karger <steffan@...1856...>
Date: 2016-09-29 20:49 GMT+03:00
Subject: Re: [Openvpn-devel] [PATCH] Fix duplicated PUSH_REPLY options
To: Lev Stipakov <lstipakov@...277...>


Hi,

On 24 September 2016 at 12:23, Lev Stipakov <lstipakov@...277...> wrote:
> Starting from https://github.com/OpenVPN/openvpn/commit/3a5a46cf2b7f6a8b85
20c2513a8054deb48bfcbe,
> we add peer-id and cipher values to context->options->push_list instead
of adding those directly
> to buf (as done for client-specific values, like ifconfig). Since
push_list is per child context,
> when options are added and context is reused - we got duplicates.
>
> Fixed by adding options to buffer, as it was done previously.

NAK.  This reintroduces another issue, where the added options might
not fit into buf, because we can't reserve space for variable-sized
options (peer-id would be possible, by cipher would already be
trickier).

This is a bug though (sorry!), so attached a different proposal to fix
this.  I didn't test this yet (need to leave now), but lev just
announced on IRC that he was willing to test it.

-Steffan



-- 
-Lev

--001a1148f5c20e1595053dce3577
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span style=3D"font-size:12.8px">Hi,</span><div style=
=3D"font-size:12.8px"><br></div><div style=3D"font-size:12.8px">Attempt #2 =
- now with attached patch.</div><div style=3D"font-size:12.8px"><br></div><=
div style=3D"font-size:12.8px">ACK from me - tested that peer-id and cipher=
 are not duplicated in PUSH_REPLY when client reconnects and push-continuat=
ion works.=C2=A0</div><div style=3D"font-size:12.8px"><br></div><div style=
=3D"font-size:12.8px">-Lev</div></div><div><br></div><br><div class=3D"gmai=
l_quote">---------- Forwarded message ----------<br>From: <b class=3D"gmail=
_sendername">Steffan Karger</b> <span dir=3D"ltr">&lt;<a href=3D"mailto:ste=
ffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt;</span><br>Dat=
e: 2016-09-29 20:49 GMT+03:00<br>Subject: Re: [Openvpn-devel] [PATCH] Fix d=
uplicated PUSH_REPLY options<br>To: Lev Stipakov &lt;<a href=3D"mailto:lsti=
pakov@...277..." target=3D"_blank">lstipakov@...277...</a>&gt;<br><br><br>H=
i,<br>
<span class=3D"m_7525302543725694024gmail-"><br>
On 24 September 2016 at 12:23, Lev Stipakov &lt;<a href=3D"mailto:lstipakov=
@...277..." target=3D"_blank">lstipakov@...277...</a>&gt; wrote:<br>
&gt; Starting from <a href=3D"https://github.com/OpenVPN/openvpn/commit/3a5=
a46cf2b7f6a8b8520c2513a8054deb48bfcbe" rel=3D"noreferrer" target=3D"_blank"=
>https://github.com/OpenVPN/ope<wbr>nvpn/commit/3a5a46cf2b7f6a8b85<wbr>20c2=
513a8054deb48bfcbe</a>,<br>
&gt; we add peer-id and cipher values to context-&gt;options-&gt;push_list =
instead of adding those directly<br>
&gt; to buf (as done for client-specific values, like ifconfig). Since push=
_list is per child context,<br>
&gt; when options are added and context is reused - we got duplicates.<br>
&gt;<br>
&gt; Fixed by adding options to buffer, as it was done previously.<br>
<br>
</span>NAK.=C2=A0 This reintroduces another issue, where the added options =
might<br>
not fit into buf, because we can&#39;t reserve space for variable-sized<br>
options (peer-id would be possible, by cipher would already be<br>
trickier).<br>
<br>
This is a bug though (sorry!), so attached a different proposal to fix<br>
this.=C2=A0 I didn&#39;t test this yet (need to leave now), but lev just<br>
announced on IRC that he was willing to test it.<br>
<span class=3D"m_7525302543725694024gmail-HOEnZb"><font color=3D"#888888"><=
br>
-Steffan<br>
</font></span></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"m_7525302543725694024gmail_signature">-Lev</div>
</div>

--001a1148f5c20e1595053dce3577--

--001a1148f5c20e159d053dce3579
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Fix-duplicate-PUSH_REPLY-options.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-duplicate-PUSH_REPLY-options.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_itomx7pw0

RnJvbSA5NTdjNTRhN2Y0Y2VmZGMwNWU1ZTg3NjE5NWVmMzFhNTJjMDBmMmIzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmZmFuIEthcmdlciA8c3RlZmZhbkBrYXJnZXIubWU+CkRh
dGU6IFRodSwgMjkgU2VwIDIwMTYgMTk6NDg6MjkgKzAyMDAKU3ViamVjdDogW1BBVENIXSBGaXgg
ZHVwbGljYXRlIFBVU0hfUkVQTFkgb3B0aW9ucwoKQXMgcmVwb3J0ZWQgYnkgTGV2IFN0aXBha292
LCBzdGFydGluZyBmcm9tIDNhNWE0NmNmIHdlIGFkZCBwZWVyLWlkIGFuZApjaXBoZXIgdmFsdWVz
IHRvIGNvbnRleHQtPm9wdGlvbnMtPnB1c2hfbGlzdCBpbnN0ZWFkIG9mIGFkZGluZyB0aG9zZQpk
aXJlY3RseSB0byBidWYuIFNpbmNlIHB1c2hfbGlzdCBpcyBwcmVzZXJ2ZWQgb3ZlciBzaWd1c3Ix
IHJlc3RhcnRzLAp3ZSBhZGQgZHVwbGljYXRlIHZhbHVlcyBmb3IgcGVlci1pZCBhbmQgY2lwaGVy
LgoKRml4ZWQgYnkgcmVtb3ZpbmcgdGhlIHByZXZpb3VzIHZhbHVlcyBmcm9tIHRoZSBsaXN0IGJl
Zm9yZSBhZGRpbmcgbmV3IG9uZXMuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmZmFuIEthcmdlciA8c3Rl
ZmZhbkBrYXJnZXIubWU+Ci0tLQogc3JjL29wZW52cG4vZXJybGV2ZWwuaCB8IDEgKwogc3JjL29w
ZW52cG4vb3B0aW9ucy5jICB8IDEgKwogc3JjL29wZW52cG4vcHVzaC5jICAgICB8IDYgKysrKy0t
CiAzIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9zcmMvb3BlbnZwbi9lcnJsZXZlbC5oIGIvc3JjL29wZW52cG4vZXJybGV2ZWwuaApp
bmRleCBkYTYwMGFiLi5hZTFmOGY0IDEwMDY0NAotLS0gYS9zcmMvb3BlbnZwbi9lcnJsZXZlbC5o
CisrKyBiL3NyYy9vcGVudnBuL2VycmxldmVsLmgKQEAgLTE0Nyw2ICsxNDcsNyBAQAogI2RlZmlu
ZSBEX1BJRF9ERUJVRyAgICAgICAgICBMT0dMRVYoNywgNzAsIE1fREVCVUcpICAvKiBzaG93IHBh
Y2tldC1pZCBkZWJ1Z2dpbmcgaW5mbyAqLwogI2RlZmluZSBEX1BGX0RST1BQRURfQkNBU1QgICBM
T0dMRVYoNywgNzEsIE1fREVCVUcpICAvKiBwYWNrZXQgZmlsdGVyIGRyb3BwZWQgYSBicm9hZGNh
c3QgcGFja2V0ICovCiAjZGVmaW5lIERfUEZfREVCVUcgICAgICAgICAgIExPR0xFVig3LCA3Miwg
TV9ERUJVRykgIC8qIHBhY2tldCBmaWx0ZXIgZGVidWdnaW5nLCBtdXN0IGFsc28gZGVmaW5lIFBG
X0RFQlVHIGluIHBmLmggKi8KKyNkZWZpbmUgRF9QVVNIX0RFQlVHICAgICAgICAgTE9HTEVWKDcs
IDczLCBNX0RFQlVHKSAgLyogc2hvdyBwdXNoL3B1bGwgZGVidWdnaW5nIGluZm8gKi8KIAogI2Rl
ZmluZSBEX0hBTkRTSEFLRV9WRVJCT1NFICBMT0dMRVYoOCwgNzAsIE1fREVCVUcpICAvKiBzaG93
IGRldGFpbGVkIGRlc2NyaXB0aW9uIG9mIGVhY2ggaGFuZHNoYWtlICovCiAjZGVmaW5lIERfVExT
X0RFQlVHX01FRCAgICAgIExPR0xFVig4LCA3MCwgTV9ERUJVRykgIC8qIGxpbWl0ZWQgaW5mbyBm
cm9tIHRsc19zZXNzaW9uIHJvdXRpbmVzICovCmRpZmYgLS1naXQgYS9zcmMvb3BlbnZwbi9vcHRp
b25zLmMgYi9zcmMvb3BlbnZwbi9vcHRpb25zLmMKaW5kZXggNTNiNDYxNy4uY2NiNmIyOCAxMDA2
NDQKLS0tIGEvc3JjL29wZW52cG4vb3B0aW9ucy5jCisrKyBiL3NyYy9vcGVudnBuL29wdGlvbnMu
YwpAQCAtNTc4MSw2ICs1NzgxLDcgQEAgYWRkX29wdGlvbiAoc3RydWN0IG9wdGlvbnMgKm9wdGlv
bnMsCiAgIGVsc2UgaWYgKHN0cmVxIChwWzBdLCAicHVzaC1yZW1vdmUiKSAmJiBwWzFdICYmICFw
WzJdKQogICAgIHsKICAgICAgIFZFUklGWV9QRVJNSVNTSU9OIChPUFRfUF9JTlNUQU5DRSk7Cisg
ICAgICBtc2cgKERfUFVTSCwgIlBVU0hfUkVNT1ZFICclcyciLCBwWzFdKTsKICAgICAgIHB1c2hf
cmVtb3ZlX29wdGlvbiAob3B0aW9ucyxwWzFdKTsKICAgICB9CiAgIGVsc2UgaWYgKHN0cmVxIChw
WzBdLCAiaWZjb25maWctcG9vbCIpICYmIHBbMV0gJiYgcFsyXSAmJiAhcFs0XSkKZGlmZiAtLWdp
dCBhL3NyYy9vcGVudnBuL3B1c2guYyBiL3NyYy9vcGVudnBuL3B1c2guYwppbmRleCBhMWI5OTll
Li40ZDFkZDM0IDEwMDY0NAotLS0gYS9zcmMvb3BlbnZwbi9wdXNoLmMKKysrIGIvc3JjL29wZW52
cG4vcHVzaC5jCkBAIC0zMTQsNiArMzE0LDcgQEAgcHJlcGFyZV9wdXNoX3JlcGx5IChzdHJ1Y3Qg
b3B0aW9ucyAqbywgc3RydWN0IHRsc19tdWx0aSAqdGxzX211bHRpKQogICAgICAgaW50IHIgPSBz
c2NhbmYob3B0c3RyLCAiSVZfUFJPVE89JWQiLCAmcHJvdG8pOwogICAgICAgaWYgKChyID09IDEp
ICYmIChwcm90byA+PSAyKSkKIAl7CisJICBwdXNoX3JlbW92ZV9vcHRpb24obywgInBlZXItaWQi
KTsKIAkgIHB1c2hfb3B0aW9uX2ZtdChvLCBNX1VTQUdFLCAicGVlci1pZCAlZCIsIHRsc19tdWx0
aS0+cGVlcl9pZCk7CiAJfQogICAgIH0KQEAgLTMzNyw2ICszMzgsNyBAQCBwcmVwYXJlX3B1c2hf
cmVwbHkgKHN0cnVjdCBvcHRpb25zICpvLCBzdHJ1Y3QgdGxzX211bHRpICp0bHNfbXVsdGkpCiAJ
ICAgKiBUT0RPOiBhY3R1YWwgbmVnb3RpYXRpb24sIGluc3RlYWQgb2Ygc2VydmVyIGRpY3RhdG9y
c2hpcC4gKi8KIAkgIGNoYXIgKnB1c2hfY2lwaGVyID0gc3RyaW5nX2FsbG9jKG8tPm5jcF9jaXBo
ZXJzLCAmby0+Z2MpOwogCSAgby0+Y2lwaGVybmFtZSA9IHN0cnRvayAocHVzaF9jaXBoZXIsICI6
Iik7CisJICBwdXNoX3JlbW92ZV9vcHRpb24obywgImNpcGhlciIpOwogCSAgcHVzaF9vcHRpb25f
Zm10KG8sIE1fVVNBR0UsICJjaXBoZXIgJXMiLCBvLT5jaXBoZXJuYW1lKTsKIAl9CiAgICAgfQpA
QCAtNTI1LDcgKzUyNyw3IEBAIHB1c2hfcmVzZXQgKHN0cnVjdCBvcHRpb25zICpvKQogdm9pZAog
cHVzaF9yZW1vdmVfb3B0aW9uIChzdHJ1Y3Qgb3B0aW9ucyAqbywgY29uc3QgY2hhciAqcCkKIHsK
LSAgbXNnKCBEX1BVU0gsICJQVVNIX1JFTU9WRSAnJXMnIiwgcCApOworICBtc2cgKERfUFVTSF9E
RUJVRywgIlBVU0hfUkVNT1ZFIHNlYXJjaGluZyBmb3I6ICclcyciLCBwKTsKIAogICAvKiBpZmNv
bmZpZy1pcHY2IGlzIHNwZWNpYWwsIGFzIG5vdCBwYXJ0IG9mIHRoZSBwdXNoIGxpc3QgKi8KICAg
aWYgKCBzdHJlcSggcCwgImlmY29uZmlnLWlwdjYiICkpCkBAIC01NDQsNyArNTQ2LDcgQEAgcHVz
aF9yZW1vdmVfb3B0aW9uIChzdHJ1Y3Qgb3B0aW9ucyAqbywgY29uc3QgY2hhciAqcCkKIAkgIGlm
ICggZS0+ZW5hYmxlICYmCiAgICAgICAgICAgICAgICBzdHJuY21wKCBlLT5vcHRpb24sIHAsIHN0
cmxlbihwKSApID09IDAgKQogCSAgICB7Ci0JICAgICAgbXNnIChEX1BVU0gsICJQVVNIX1JFTU9W
RSByZW1vdmluZzogJyVzJyIsIGUtPm9wdGlvbik7CisJICAgICAgbXNnIChEX1BVU0hfREVCVUcs
ICJQVVNIX1JFTU9WRSByZW1vdmluZzogJyVzJyIsIGUtPm9wdGlvbik7CiAJICAgICAgZS0+ZW5h
YmxlID0gZmFsc2U7CiAJICAgIH0KIAotLSAKMi43LjQKCg==
--001a1148f5c20e159d053dce3579--

