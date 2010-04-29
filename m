MIME-Version: 1.0
Sender: ichiga2@...277...
In-Reply-To: <20100429070756.GX12312@...1296...>
References: <i2j251896ce1004282102v38fd0e79l2a222c4501dad9db@...278...> 
	<20100429070756.GX12312@...1296...>
From: Kazuyoshi Aizawa <admin2@...628...>
Date: Thu, 29 Apr 2010 16:45:45 +0900
Message-ID: <v2l251896ce1004290045z24d80f3bjb09a5331893accfa@...278...>
Content-Type: multipart/mixed; boundary=000e0cd5cd90a4ca9904855b51b9
Subject: Re: [Openvpn-devel] [PATCH] TAP interface support for
	Solaris/OpenSolaris
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000e0cd5cd90a4ca9904855b51b9
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Gert,

Thank you for your support.
Please find attached patch with diff -uw.

Thanks,

Kazuyoshi

2010/4/29 Gert Doering <gert@...1296...>:
> Hi again,
>
> On Thu, Apr 29, 2010 at 01:02:37PM +0900, Kazuyoshi Aizawa wrote:
>> I've attached a patch for tun.c which includes support for tap
>> interface for solaris/opensolaris.
>
> I've glanced through the patch, and there's also changes in the Win32
> part of the tun.c, for example this chunk:
>
>
> ----------------------- quote ----------------------
> @@ -3333,19 +3409,19 @@
> =A0 bool ret =3D false;
> =A0 const IP_ADAPTER_INDEX_MAP *inter =3D get_interface_info (adapter_ind=
ex, &gc);
>
> - =A0if (inter)
> - =A0 =A0{
> - =A0 =A0 =A0DWORD status =3D IpRenewAddress ((IP_ADAPTER_INDEX_MAP *)int=
er);
> - =A0 =A0 =A0if (status =3D=3D NO_ERROR)
> + =A0 =A0 =A0if (inter)
> =A0 =A0 =A0 =A0{
> - =A0 =A0 =A0 =A0 msg (D_TUNTAP_INFO, "TAP: DHCP address renewal succeede=
d");
> - =A0 =A0 =A0 =A0 ret =3D true;
> + =A0 =A0 =A0 =A0 DWORD status =3D IpRenewAddress ((IP_ADAPTER_INDEX_MAP =
*)inter);
> + =A0 =A0 =A0 =A0 if (status =3D=3D NO_ERROR)
> + =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 msg (D_TUNTAP_INFO, "TAP: DHCP address renewal =
succeeded");
> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D true;
> + =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 msg (M_WARN, "WARNING: Failed to renew DHCP IP addr=
ess lease on TAP-Win32 adapter: %s (code=3D%u)",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strerror_win32 (status, &gc),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned int)status);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0else
> - =A0 =A0 =A0 msg (M_WARN, "WARNING: Failed to renew DHCP IP address leas=
e on TAP-Win32 adapter: %s (code=3D%u)",
> - =A0 =A0 =A0 =A0 =A0 =A0strerror_win32 (status, &gc),
> - =A0 =A0 =A0 =A0 =A0 =A0(unsigned int)status);
> - =A0 =A0}
> =A0 gc_free (&gc);
> =A0 return ret;
> =A0}
> ----------------------- quote ----------------------
>
>
> From a first glance, this looks like "whitespace changes only".
>
> For easier review: would you be so kind and re-send your patch with
> "diff -uw" (-w =3D ignore white space changes)?
>
> thanks,
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //www.muc.de/~gert/
> Gert Doering - Munich, Germany =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 gert@...1296...
> fax: +49-89-35655025 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gert@=
...1297...
>
>

--000e0cd5cd90a4ca9904855b51b9
Content-Type: application/octet-stream; name="tun.c_tap_solaris.patch"
Content-Disposition: attachment; filename="tun.c_tap_solaris.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g8l9smlm0

LS0tIC4vb3BlbnZwbi0yLjEuMS1vcmcvdHVuLmMJVGh1IEFwciAyOSAxNjozMTo0MyAyMDEwCisr
KyAuL29wZW52cG4tMi4xLjEvdHVuLmMJVGh1IEFwciAyOSAxMToyNDo0OCAyMDEwCkBAIC02Myw2
ICs2Myw3IEBACiAKICNpZmRlZiBUQVJHRVRfU09MQVJJUwogc3RhdGljIHZvaWQgc29sYXJpc19l
cnJvcl9jbG9zZSAoc3RydWN0IHR1bnRhcCAqdHQsIGNvbnN0IHN0cnVjdCBlbnZfc2V0ICplcywg
Y29uc3QgY2hhciAqYWN0dWFsKTsKKyNpbmNsdWRlIDxzdHJvcHRzLmg+CiAjZW5kaWYKIAogYm9v
bApAQCAtNzAxLDcgKzcwMiwxMyBAQAogCQkJICAgICk7CiAJfQogICAgICAgZWxzZQotCW5vX3Rh
cF9pZmNvbmZpZyAoKTsKKyAgICAgICAgICBhcmd2X3ByaW50ZiAoJmFyZ3YsCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIiAlcyAlcyAlcyBuZXRtYXNrICVzIGJyb2FkY2FzdCArIHVwIiwK
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICBJRkNPTkZJR19QQVRILAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGFjdHVhbCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZmNv
bmZpZ19sb2NhbCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZmNvbmZpZ19yZW1vdGVf
bmV0bWFzaworICAgICAgICAgICAgICAgICAgICAgICAgICAgICk7CiAKICAgICAgIGFyZ3ZfbXNn
IChNX0lORk8sICZhcmd2KTsKICAgICAgIGlmICghb3BlbnZwbl9leGVjdmVfY2hlY2sgKCZhcmd2
LCBlcywgMCwgIlNvbGFyaXMgaWZjb25maWcgcGhhc2UtMiBmYWlsZWQiKSkKQEAgLTEzODMsMTUg
KzEzOTAsMTcgQEAKIHZvaWQKIG9wZW5fdHVuIChjb25zdCBjaGFyICpkZXYsIGNvbnN0IGNoYXIg
KmRldl90eXBlLCBjb25zdCBjaGFyICpkZXZfbm9kZSwgYm9vbCBpcHY2LCBzdHJ1Y3QgdHVudGFw
ICp0dCkKIHsKLSAgaW50IGlmX2ZkLCBtdXhpZCwgcHBhID0gLTE7Ci0gIHN0cnVjdCBpZnJlcSBp
ZnI7CisgIGludCBpZl9mZCwgaXBfbXV4aWQsIGFycF9tdXhpZCwgYXJwX2ZkLCBwcGEgPSAtMTsK
KyAgc3RydWN0IGxpZnJlcSBpZnI7CiAgIGNvbnN0IGNoYXIgKnB0cjsKLSAgY29uc3QgY2hhciAq
aXBfbm9kZTsKKyAgY29uc3QgY2hhciAqaXBfbm9kZSwgKmFycF9ub2RlOwogICBjb25zdCBjaGFy
ICpkZXZfdHVudGFwX3R5cGU7CiAgIGludCBsaW5rX3R5cGU7CiAgIGJvb2wgaXNfdHVuOworICBz
dHJ1Y3Qgc3RyaW9jdGwgIHN0cmlvY19pZiwgc3RyaW9jX3BwYTsKIAotICBpcHY2X3N1cHBvcnQg
KGlwdjYsIGZhbHNlLCB0dCk7CisgIGlwdjZfc3VwcG9ydCAoaXB2NiwgdHJ1ZSwgdHQpOworICBt
ZW1zZXQoJmlmciwgMHgwLCBzaXplb2YoaWZyKSk7CiAKICAgaWYgKHR0LT50eXBlID09IERFVl9U
WVBFX05VTEwpCiAgICAgewpAQCAtMTQxMCw5ICsxNDE5LDEwIEBACiAgICAgfQogICBlbHNlIGlm
ICh0dC0+dHlwZSA9PSBERVZfVFlQRV9UQVApCiAgICAgewotICAgICAgaXBfbm9kZSA9ICIvZGV2
L2lwIjsKKyAgICAgIGlwX25vZGUgPSAiL2Rldi91ZHAiOwogICAgICAgaWYgKCFkZXZfbm9kZSkK
IAlkZXZfbm9kZSA9ICIvZGV2L3RhcCI7CisgICAgICBhcnBfbm9kZSA9IGRldl9ub2RlOwogICAg
ICAgZGV2X3R1bnRhcF90eXBlID0gInRhcCI7CiAgICAgICBsaW5rX3R5cGUgPSBJX1BMSU5LOyAv
KiB3YXM6IElfTElOSyAqLwogICAgICAgaXNfdHVuID0gZmFsc2U7CkBAIC0xNDM5LDcgKzE0NDks
MTEgQEAKICAgICBtc2cgKE1fRVJSLCAiQ2FuJ3Qgb3BlbiAlcyIsIGRldl9ub2RlKTsKIAogICAv
KiBBc3NpZ24gYSBuZXcgUFBBIGFuZCBnZXQgaXRzIHVuaXQgbnVtYmVyLiAqLwotICBpZiAoKHBw
YSA9IGlvY3RsICh0dC0+ZmQsIFRVTk5FV1BQQSwgcHBhKSkgPCAwKQorICBzdHJpb2NfcHBhLmlj
X2NtZCA9IFRVTk5FV1BQQTsKKyAgc3RyaW9jX3BwYS5pY190aW1vdXQgPSAwOworICBzdHJpb2Nf
cHBhLmljX2xlbiA9IHNpemVvZihwcGEpOworICBzdHJpb2NfcHBhLmljX2RwID0gKGNoYXIgKikm
cHBhOworICBpZiAoKHBwYSA9IGlvY3RsICh0dC0+ZmQsIElfU1RSLCAmc3RyaW9jX3BwYSkpIDwg
MCkKICAgICBtc2cgKE1fRVJSLCAiQ2FuJ3QgYXNzaWduIG5ldyBpbnRlcmZhY2UiKTsKIAogICBp
ZiAoKGlmX2ZkID0gb3BlbiAoZGV2X25vZGUsIE9fUkRXUiwgMCkpIDwgMCkKQEAgLTE0NDgsMjcg
KzE0NjIsODMgQEAKICAgaWYgKGlvY3RsIChpZl9mZCwgSV9QVVNILCAiaXAiKSA8IDApCiAgICAg
bXNnIChNX0VSUiwgIkNhbid0IHB1c2ggSVAgbW9kdWxlIik7CiAKKyAgaWYgKHR0LT50eXBlID09
IERFVl9UWVBFX1RVTikKKyAgICB7CiAgIC8qIEFzc2lnbiBwcGEgYWNjb3JkaW5nIHRvIHRoZSB1
bml0IG51bWJlciByZXR1cm5lZCBieSB0dW4gZGV2aWNlICovCiAgIGlmIChpb2N0bCAoaWZfZmQs
IElGX1VOSVRTRUwsIChjaGFyICopICZwcGEpIDwgMCkKICAgICBtc2cgKE1fRVJSLCAiQ2FuJ3Qg
c2V0IFBQQSAlZCIsIHBwYSk7CisgICAgfQogCi0gIGlmICgobXV4aWQgPSBpb2N0bCAodHQtPmlw
X2ZkLCBsaW5rX3R5cGUsIGlmX2ZkKSkgPCAwKQotICAgIG1zZyAoTV9FUlIsICJDYW4ndCBsaW5r
ICVzIGRldmljZSB0byBJUCIsIGRldl90dW50YXBfdHlwZSk7Ci0KLSAgY2xvc2UgKGlmX2ZkKTsK
LQogICB0dC0+YWN0dWFsX25hbWUgPSAoY2hhciAqKSBtYWxsb2MgKDMyKTsKICAgY2hlY2tfbWFs
bG9jX3JldHVybiAodHQtPmFjdHVhbF9uYW1lKTsKIAogICBvcGVudnBuX3NucHJpbnRmICh0dC0+
YWN0dWFsX25hbWUsIDMyLCAiJXMlZCIsIGRldl90dW50YXBfdHlwZSwgcHBhKTsKIAorICBpZiAo
dHQtPnR5cGUgPT0gREVWX1RZUEVfVEFQKQorICAgIHsKKyAgICAgICAgICBpZiAoaW9jdGwoaWZf
ZmQsIFNJT0NHTElGRkxBR1MsICZpZnIpIDwgMCkKKyAgICAgICAgICAgIG1zZyAoTV9FUlIsICJD
YW4ndCBnZXQgZmxhZ3NcbiIpOworICAgICAgICAgIHN0cm5jcHludCAoaWZyLmxpZnJfbmFtZSwg
dHQtPmFjdHVhbF9uYW1lLCBzaXplb2YgKGlmci5saWZyX25hbWUpKTsKKyAgICAgICAgICBpZnIu
bGlmcl9wcGEgPSBwcGE7CisgICAgICAgICAgLyogQXNzaWduIHBwYSBhY2NvcmRpbmcgdG8gdGhl
IHVuaXQgbnVtYmVyIHJldHVybmVkIGJ5IHR1biBkZXZpY2UgKi8KKyAgICAgICAgICBpZiAoaW9j
dGwgKGlmX2ZkLCBTSU9DU0xJRk5BTUUsICZpZnIpIDwgMCkKKyAgICAgICAgICAgIG1zZyAoTV9F
UlIsICJDYW4ndCBzZXQgUFBBICVkIiwgcHBhKTsKKyAgICAgICAgICBpZiAoaW9jdGwoaWZfZmQs
IFNJT0NHTElGRkxBR1MsICZpZnIpIDwwKQorICAgICAgICAgICAgbXNnIChNX0VSUiwgIkNhbid0
IGdldCBmbGFnc1xuIik7CisgICAgICAgICAgLyogUHVzaCBhcnAgbW9kdWxlIHRvIGlmX2ZkICov
CisgICAgICAgICAgaWYgKGlvY3RsIChpZl9mZCwgSV9QVVNILCAiYXJwIikgPCAwKQorICAgICAg
ICAgICAgbXNnIChNX0VSUiwgIkNhbid0IHB1c2ggQVJQIG1vZHVsZSIpOworCisgICAgICAgICAg
LyogUG9wIGFueSBtb2R1bGVzIG9uIHRoZSBzdHJlYW0gKi8KKyAgICAgICAgICB3aGlsZSAodHJ1
ZSkKKyAgICAgICAgICAgIHsKKyAgICAgICAgICAgICAgICAgaWYgKGlvY3RsICh0dC0+aXBfZmQs
IElfUE9QLCBOVUxMKSA8IDApCisgICAgICAgICAgICAgICAgICAgICBicmVhazsKKyAgICAgICAg
ICAgIH0KKyAgICAgICAgICAvKiBQdXNoIGFycCBtb2R1bGUgdG8gaXBfZmQgKi8KKyAgICAgICAg
ICBpZiAoaW9jdGwgKHR0LT5pcF9mZCwgSV9QVVNILCAiYXJwIikgPCAwKQorICAgICAgICAgICAg
bXNnIChNX0VSUiwgIkNhbid0IHB1c2ggQVJQIG1vZHVsZVxuIik7CisKKyAgICAgICAgICAvKiBP
cGVuIGFycF9mZCAqLworICAgICAgICAgIGlmICgoYXJwX2ZkID0gb3BlbiAoYXJwX25vZGUsIE9f
UkRXUiwgMCkpIDwgMCkKKyAgICAgICAgICAgIG1zZyAoTV9FUlIsICJDYW4ndCBvcGVuICVzXG4i
LCBhcnBfbm9kZSk7CisgICAgICAgICAgLyogUHVzaCBhcnAgbW9kdWxlIHRvIGFycF9mZCAqLwor
ICAgICAgICAgIGlmIChpb2N0bCAoYXJwX2ZkLCBJX1BVU0gsICJhcnAiKSA8IDApCisgICAgICAg
ICAgICBtc2cgKE1fRVJSLCAiQ2FuJ3QgcHVzaCBBUlAgbW9kdWxlXG4iKTsKKworICAgICAgICAg
IC8qIFNldCBpZm5hbWUgdG8gYXJwICovCisgICAgICAgICAgc3RyaW9jX2lmLmljX2NtZCA9IFNJ
T0NTTElGTkFNRTsKKyAgICAgICAgICBzdHJpb2NfaWYuaWNfdGltb3V0ID0gMDsKKyAgICAgICAg
ICBzdHJpb2NfaWYuaWNfbGVuID0gc2l6ZW9mKGlmcik7CisgICAgICAgICAgc3RyaW9jX2lmLmlj
X2RwID0gKGNoYXIgKikmaWZyOworICAgICAgICAgIGlmIChpb2N0bChhcnBfZmQsIElfU1RSLCAm
c3RyaW9jX2lmKSA8IDApeworICAgICAgICAgICAgICBtc2cgKE1fRVJSLCAiQ2FuJ3Qgc2V0IGlm
bmFtZSB0byBhcnBcbiIpOworICAgICAgICAgIH0KKyAgIH0KKworICBpZiAoKGlwX211eGlkID0g
aW9jdGwgKHR0LT5pcF9mZCwgbGlua190eXBlLCBpZl9mZCkpIDwgMCkKKyAgICBtc2cgKE1fRVJS
LCAiQ2FuJ3QgbGluayAlcyBkZXZpY2UgdG8gSVAiLCBkZXZfdHVudGFwX3R5cGUpOworCisgIGlm
ICh0dC0+dHlwZSA9PSBERVZfVFlQRV9UQVApIHsKKyAgICAgICAgICBpZiAoKGFycF9tdXhpZCA9
IGlvY3RsICh0dC0+aXBfZmQsIGxpbmtfdHlwZSwgYXJwX2ZkKSkgPCAwKQorICAgICAgICAgICAg
bXNnIChNX0VSUiwgIkNhbid0IGxpbmsgJXMgZGV2aWNlIHRvIEFSUCIsIGRldl90dW50YXBfdHlw
ZSk7CisgICAgICAgICAgY2xvc2UgKGFycF9mZCk7CisgIH0KKwogICBDTEVBUiAoaWZyKTsKLSAg
c3RybmNweW50IChpZnIuaWZyX25hbWUsIHR0LT5hY3R1YWxfbmFtZSwgc2l6ZW9mIChpZnIuaWZy
X25hbWUpKTsKLSAgaWZyLmlmcl9pcF9tdXhpZCA9IG11eGlkOworICBzdHJuY3B5bnQgKGlmci5s
aWZyX25hbWUsIHR0LT5hY3R1YWxfbmFtZSwgc2l6ZW9mIChpZnIubGlmcl9uYW1lKSk7CisgIGlm
ci5saWZyX2lwX211eGlkICA9IGlwX211eGlkOworICBpZiAodHQtPnR5cGUgPT0gREVWX1RZUEVf
VEFQKSB7CisgICAgICAgICAgaWZyLmxpZnJfYXJwX211eGlkID0gYXJwX211eGlkOworICB9CiAK
LSAgaWYgKGlvY3RsICh0dC0+aXBfZmQsIFNJT0NTSUZNVVhJRCwgJmlmcikgPCAwKQorICBpZiAo
aW9jdGwgKHR0LT5pcF9mZCwgU0lPQ1NMSUZNVVhJRCwgJmlmcikgPCAwKQogICAgIHsKLSAgICAg
IGlvY3RsICh0dC0+aXBfZmQsIElfUFVOTElOSywgbXV4aWQpOworICAgICAgaWYgKHR0LT50eXBl
ID09IERFVl9UWVBFX1RBUCkKKyAgICAgICAgeworICAgICAgICAgICAgICBpb2N0bCAodHQtPmlw
X2ZkLCBJX1BVTkxJTksgLCBhcnBfbXV4aWQpOworICAgICAgICB9CisgICAgICBpb2N0bCAodHQt
PmlwX2ZkLCBJX1BVTkxJTkssIGlwX211eGlkKTsKICAgICAgIG1zZyAoTV9FUlIsICJDYW4ndCBz
ZXQgbXVsdGlwbGV4b3IgaWQiKTsKICAgICB9CiAKQEAgLTE0ODYsMTkgKzE1NTYsMjUgQEAKICAg
ICB7CiAgICAgICBpZiAodHQtPmlwX2ZkID49IDApCiAJewotCSAgc3RydWN0IGlmcmVxIGlmcjsK
KyAgICAgICAgICBzdHJ1Y3QgbGlmcmVxIGlmcjsKIAkgIENMRUFSIChpZnIpOwotCSAgc3RybmNw
eW50IChpZnIuaWZyX25hbWUsIHR0LT5hY3R1YWxfbmFtZSwgc2l6ZW9mIChpZnIuaWZyX25hbWUp
KTsKKyAgICAgICAgICBzdHJuY3B5bnQgKGlmci5saWZyX25hbWUsIHR0LT5hY3R1YWxfbmFtZSwg
c2l6ZW9mIChpZnIubGlmcl9uYW1lKSk7CiAKLQkgIGlmIChpb2N0bCAodHQtPmlwX2ZkLCBTSU9D
R0lGRkxBR1MsICZpZnIpIDwgMCkKKyAgICAgICAgICBpZiAoaW9jdGwgKHR0LT5pcF9mZCwgU0lP
Q0dMSUZGTEFHUywgJmlmcikgPCAwKQogCSAgICBtc2cgKE1fV0FSTiB8IE1fRVJSTk8sICJDYW4n
dCBnZXQgaWZhY2UgZmxhZ3MiKTsKIAotCSAgaWYgKGlvY3RsICh0dC0+aXBfZmQsIFNJT0NHSUZN
VVhJRCwgJmlmcikgPCAwKQorICAgICAgICAgIGlmIChpb2N0bCAodHQtPmlwX2ZkLCBTSU9DR0xJ
Rk1VWElELCAmaWZyKSA8IDApCiAJICAgIG1zZyAoTV9XQVJOIHwgTV9FUlJOTywgIkNhbid0IGdl
dCBtdWx0aXBsZXhvciBpZCIpOwogCi0JICBpZiAoaW9jdGwgKHR0LT5pcF9mZCwgSV9QVU5MSU5L
LCBpZnIuaWZyX2lwX211eGlkKSA8IDApCi0JICAgIG1zZyAoTV9XQVJOIHwgTV9FUlJOTywgIkNh
bid0IHVubGluayBpbnRlcmZhY2UiKTsKKyAgICAgICAgICBpZiAodHQtPnR5cGUgPT0gREVWX1RZ
UEVfVEFQKQorICAgICAgICAgICAgeworICAgICAgICAgICAgICAgICAgaWYgKGlvY3RsICh0dC0+
aXBfZmQsIElfUFVOTElOSywgaWZyLmxpZnJfYXJwX211eGlkKSA8IDApCisgICAgICAgICAgICAg
ICAgICAgIG1zZyAoTV9XQVJOIHwgTV9FUlJOTywgIkNhbid0IHVubGluayBpbnRlcmZhY2UoYXJw
KSIpOworICAgICAgICAgICAgfQogCisgICAgICAgICAgaWYgKGlvY3RsICh0dC0+aXBfZmQsIElf
UFVOTElOSywgaWZyLmxpZnJfaXBfbXV4aWQpIDwgMCkKKyAgICAgICAgICAgIG1zZyAoTV9XQVJO
IHwgTV9FUlJOTywgIkNhbid0IHVubGluayBpbnRlcmZhY2UoaXApIik7CisKIAkgIGNsb3NlICh0
dC0+aXBfZmQpOwogCSAgdHQtPmlwX2ZkID0gLTE7CiAJfQo=
--000e0cd5cd90a4ca9904855b51b9--

