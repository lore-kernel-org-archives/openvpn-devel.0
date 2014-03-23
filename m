MIME-Version: 1.0
In-Reply-To: <20140323122624.GD16637@...1296...>
References: <1395017376-24554-1-git-send-email-james@...515...>
	<20140317202910.GM16637@...1296...> <532775DD.4050106@...515...>
	<1CED409804E2164C8104F9E623B08B90155646D4C1@...1436...>
	<53281720.2050504@...1147...> <5328463F.7090704@...1114...>
	<53284DA8.1010709@...1147...>
	<1CED409804E2164C8104F9E623B08B9016F95AD5DC@...1436...>
	<20140322183508.GZ16637@...1296...>
	<CAA1AbxJMVBtOgeswADw_Q1XuKyK6h_jWmVg-gUqPPtM2XCk1kA@...278...>
	<20140323122624.GD16637@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 23 Mar 2014 14:27:43 +0100
Message-ID: <CAA1AbxJh17KYmVU1BVa5kp4iJsUJT+xnXp0rVU_3g3c5hPnqDQ@...278...>
Content-Type: multipart/mixed; boundary=089e01634f6ec209e904f54616ce
Subject: Re: [Openvpn-devel] [PATCH] Set SSL_OP_NO_TICKET flag in SSL
 context for OpenSSL builds, to disable TLS stateless session resumption.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e01634f6ec209e904f54616ce
Content-Type: multipart/alternative; boundary=089e01634f6ec209e404f54616cc

--089e01634f6ec209e404f54616cc
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Mar 23, 2014 at 1:26 PM, Gert Doering <gert@...1296...> wrote:

> On Sun, Mar 23, 2014 at 10:22:57AM +0100, Steffan Karger wrote:
> > ACK. Message looks correct and clear to me.
>
> Thanks.  Committed and pushed as 2cf9d4e3f06f4a61cb6d159728ac6c8a790d6849.
>
> Can you send the needed patch for master/2.4?
>

See attachment :)

-Steffan

--089e01634f6ec209e404f54616cc
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div class=3D"gmail_extra"><div class=3D"gmail_quote"=
>On Sun, Mar 23, 2014 at 1:26 PM, Gert Doering <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</spa=
n> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On Sun, Mar 23, 2014 at 10:22:57AM +0100, St=
effan Karger wrote:<br>
&gt; ACK. Message looks correct and clear to me.<br>
<br>
Thanks. =A0Committed and pushed as 2cf9d4e3f06f4a61cb6d159728ac6c8a790d6849=
.<br>
<br>
Can you send the needed patch for master/2.4?<br>
</blockquote><div><br></div><div>See attachment :)<br><br></div><div>-Steff=
an <br></div></div></div></div></div>

--089e01634f6ec209e404f54616cc--

--089e01634f6ec209e904f54616ce
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-configure.ac-check-for-SSL_OP_NO_TICKET-flag-in-Open.patch"
Content-Disposition: attachment; 
	filename="0001-configure.ac-check-for-SSL_OP_NO_TICKET-flag-in-Open.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ht4d0ma21

RnJvbSA0ZjlkNDdiZWUzYmVmNDEwMmRmZThlMTNkYTIxYWI0YmJlMGE5MmE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVmZmFuIEthcmdlciA8c3RlZmZhbkBrYXJnZXIubWU+CkRh
dGU6IFN1biwgMjMgTWFyIDIwMTQgMTQ6MDc6NDcgKzAxMDAKU3ViamVjdDogW1BBVENIXSBjb25m
aWd1cmUuYWM6IGNoZWNrIGZvciBTU0xfT1BfTk9fVElDS0VUIGZsYWcgaW4gT3BlblNTTAoKU1NM
X09QX05PX1RJQ0tFVCB0ZWxscyBPcGVuU1NMIHRvIGRpc2FibGUgInN0YXRlbGVzcyBzZXNzaW9u
IHJlc3VtcHRpb24iLgpUaGlzIGlzIHNvbWV0aGluZyB3ZSBkbyBub3Qgd2FudCBub3IgbmVlZCwg
YnV0IGNvdWxkIHBvdGVudGlhbGx5IGJlIHVzZWQKZm9yIGEgZnV0dXJlIGF0dGFjay4gT3BlblZQ
TiAyLjQgcmVxdWlyZXMgdGhlIGZsYWcgdG8gYmUgc2V0IGFuZCB3aWxsIGZhaWwKY29uZmlndXJl
IGlmIHRoZSBmbGFnIGlzIG5vdCBwcmVzZW50LgotLS0KIGNvbmZpZ3VyZS5hYyB8IDE1ICsrKysr
KysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9jb25maWd1cmUuYWMgYi9jb25maWd1cmUuYWMKaW5kZXggYzYyMmYzMy4uMmRhNjUyMSAxMDA2
NDQKLS0tIGEvY29uZmlndXJlLmFjCisrKyBiL2NvbmZpZ3VyZS5hYwpAQCAtNzkzLDYgKzc5Mywy
MSBAQCBpZiB0ZXN0ICIke2hhdmVfb3BlbnNzbF9jcnlwdG99IiA9ICJ5ZXMiOyB0aGVuCiAJTElC
Uz0iJHtzYXZlZF9MSUJTfSIKIGZpCiAKK2lmIHRlc3QgIiR7aGF2ZV9vcGVuc3NsX3NzbH0iID0g
InllcyI7IHRoZW4KKyAgICBBQ19NU0dfQ0hFQ0tJTkcoW2ZvciBTU0xfT1BfTk9fVElDS0VUIGZs
YWcgaW4gT3BlblNTTF0pCisgICAgQUNfRUdSRVBfQ1BQKGhhdmVfc3NsX29wX25vX3RpY2tldCwg
WworICAgICNpbmNsdWRlIDxvcGVuc3NsL3NzbC5oPgorICAgICNpZmRlZiBTU0xfT1BfTk9fVElD
S0VUCisgICAgaGF2ZV9zc2xfb3Bfbm9fdGlja2V0CisgICAgI2VuZGlmCisgICAgXSwgWworICAg
ICAgICBBQ19NU0dfUkVTVUxUKFt5ZXNdKQorICAgIF0sIFsKKyAgICAgICAgQUNfTVNHX1JFU1VM
VChbbm9dKQorICAgICAgICBBQ19FUlJPUihbT3BlblZQTiAyLjQrIHJlcXVpcmVzIFNTTF9PUF9O
T19USUNLRVQgaW4gT3BlblNTTF0pCisgICAgXSkKK2ZpCisKIEFDX0FSR19WQVIoW1BPTEFSU1NM
X0NGTEFHU10sIFtDIGNvbXBpbGVyIGZsYWdzIGZvciBwb2xhcnNzbF0pCiBBQ19BUkdfVkFSKFtQ
T0xBUlNTTF9MSUJTXSwgW2xpbmtlciBmbGFncyBmb3IgcG9sYXJzc2xdKQogaGF2ZV9wb2xhcnNz
bF9zc2w9InllcyIKLS0gCjEuOC4zLjIKCg==
--089e01634f6ec209e904f54616ce--

