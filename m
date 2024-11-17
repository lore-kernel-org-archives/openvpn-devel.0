Date: Sun, 17 Nov 2024 04:24:10 +0000
From: tincantech <tincantech@...2282...>
Message-ID: <9CbaYxoBHtEVLK-grSiz5jF3BIbqX9Sitzeet8RqF8GXL7Hv4BHdtdCAVEcBKdnM61OROzbjTALjF7NlvuuMJT-hHau7GUySueWeNzV0DaU=@protonmail.com>
In-Reply-To: <CAC8x_z1VvtHiB_Op7oD7xRTpVSUvefd3j1S=GKQYrxYTm4kscA@...278...>
References: <CAC8x_z0gMKW1b33J3HGL-9pQnXgpf9O6pRu+M2=xP03JyJMm6g@...278...>
 <ZzZvEOjQ4PQ3gF-2@...1296...>
 <CAC8x_z3reFPQWPNuoB-GjqkQtEgcgGapHWKUVt=OXvMoW6NCFg@...278...>
 <7df02e11-336f-4738-8221-65d1dcde0659@...515...>
 <CAC8x_z1gynaP2NHBr8HF0asnZs_ZUmGQSaFxsnbdjCuukhrS0Q@...278...>
 <197129c7-73dd-470e-9a94-7abd1b8ae19a@...1227...>
 <CAC8x_z3CdbCPnpUis7URYbQohjBy4i0z1DD75qSWPdjbWuy3XA@...278...>
 <1cc349fa-cfe3-4b83-aa1e-d941ef9e5509@...2722...>
 <CAC8x_z1VvtHiB_Op7oD7xRTpVSUvefd3j1S=GKQYrxYTm4kscA@...278...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_ERKD6pcjTWOokG3ijbrQyy6LJGE73qjbbVMjxV3t8"
Subject: Re: [Openvpn-devel] Subject: OpenVPN Client Vulnerability - TLS Key
 Negotiation Timeout Leading to DoS (Black Box Pentest)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?utf-8?B?16DXqteZINep15jXqNef?= <nsh531@...277...>
Cc: Johan Draaisma <johan@...2722...>, Antonio Quartulli <antonio@...515...>, Openvpn-devel@lists.sourceforge.net, SECURITY@...515...

--b1=_ERKD6pcjTWOokG3ijbrQyy6LJGE73qjbbVMjxV3t8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi nsh531@...277...

It is common procedure to keep security concerns to the security@ mailing l=
ist.

To have your concerns expertly reviewed, it is advisable to follow standard
security and disclosure procedures.

While this thread is, no doubt, amusing .. it is unnecessary noise on this =
list.

Please ensure that you know who you are sending your emails to, in future.

Peace and light
tct

Sent with Proton Mail secure email.

On Sunday, 17 November 2024 at 03:48, =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=
=D7=9F <nsh531@...277...> wrote:

> Hi' i sent fully logs :
>=20
>=20
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=90=
=D7=B3, 17 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-3:03 =D7=9E=D7=90=D7=
=AA =E2=80=AAJohan Draaisma=E2=80=AC=E2=80=8F <=E2=80=AAjohan@...2722...=E2=
=80=AC=E2=80=8F>:=E2=80=AC
>=20
> > Hello Natanel/Netanel,
> >=20
> > We still don't see the issue, exponential backoff is how this type of s=
ituation is handled in other common protocols too, it is a not a security v=
ulnerability. And just in case someone messes with the client side and trie=
s endlessly reconnecting much faster in an attempt to stress the server, we=
 also have other defenses in place.
> >=20
> > You also appear to be confusing server-side behavior with client-side b=
ehavior. What you are writing is that when the client is having a problem w=
ith the TLS handshake, that the server automatically restarts, as in, the p=
rocess stops and is restarted. That is simply not true. If it were true it =
would mean failed TLS handshakes from one client would affect all other con=
nected clients too, and that's something we don't see happening. But if you=
 have proof that says otherwise, show it to us with verbatim log lines, and=
 a way to reproduce it that includes version of client and server software =
used (and please, supported versions only, not versions from 8 years ago), =
client and server configurations, and the steps to reach this supposedly pr=
oblematic state. My guess however is that you are misinterpreting the messa=
ge that the client is going to do a restart of the connection, which would =
likely be visible in the server logs, and would be expected and normal.
> >=20
> > Yes, there is theoretical potential to exhaust server resources from re=
peatedly hammering the server with failing connections, as is the case with=
 many network programs. But we have various defenses in place for that. Cur=
rently with the description given I don't believe you have found something =
that broke through those defenses. But I could be wrong. But if so, I want =
to see proof, not just a story. You write that the server is automatically =
restarting in response to multiple failed TLS handshakes. Show us the evide=
nce please.
> >=20
> > Until then, we don't have anything to go on, sorry.
> >=20
> > Kind regards,
> > Johan Draaisma
> >=20
> > On 16-11-2024 17:22, =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=D7=9F wrote:
> >=20
> > > Hi,
> > > it's same on 2.6 version:
> > >=20
> > > Subject: Possible DoS Vulnerability - OpenVPN Server Showing Repeated=
 TLS Handshake Failures
> > >=20
> > > Dear OpenVPN Security Team,
> > >=20
> > > I am writing to report a potential vulnerability to Denial-of-Service=
 (DoS) attacks that I have observed in an OpenVPN server's logs. The server=
 is exhibiting consistent TLS handshake failures, resulting in repeated pro=
cess restarts. While the exact cause isn't immediately apparent, the sympto=
ms strongly suggest a vulnerability to an attack vector that overwhelms the=
 server with unsuccessful connection attempts.
> > >=20
> > > The logs demonstrate repeated errors of the form: "TLS key negotiatio=
n failed to occur within 5 seconds (check your network connectivity)" and "=
TLS handshake failed," followed by automatic server restarts. The server ap=
pears to be attempting to mitigate by increasing the restart delay with eac=
h failure, but this is only a temporary workaround, and the underlying issu=
e persists.
> > >=20
> > > The observed behavior is highly suggestive of a DoS attack, where an =
attacker is attempting to exhaust server resources by triggering multiple f=
ailed TLS handshakes. This, along with the server automatically restarting =
in response, suggests a DoS mitigation procedure is in place that can only =
temporarily avoid service outages.
> > >=20
> > > While I do not have direct access to the server configuration or the =
full scope of logs, I believe the behavior described poses a significant se=
curity risk. I have attached the partial log file demonstrating the repeate=
d errors.
> > >=20
> > > I would greatly appreciate it if you could investigate this potential=
 vulnerability and provide any guidance or recommendations for strengthenin=
g the server's resilience against this type of attack. If further informati=
on is needed, please do not hesitate to ask.
> > >=20
> > > Sincerely,
> > >=20
> > > Netanel
> > >=20
> > >=20
> > >=20
> > >=20
> > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=
=95=D7=B3, 15 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-17:30 =D7=9E=D7=90=
=D7=AA =E2=80=AAArne Schwabe=E2=80=AC=E2=80=8F <=E2=80=AAarne@...1227...=E2=
=80=AC=E2=80=8F>:=E2=80=AC
> > >=20
> > > > Am 15.11.24 um 13:56 schrieb =D7=A0=D7=AA=D7=99 =D7=A9=D7=98=D7=A8=
=D7=9F:
> > > > > I pentested openvpn 2.4 on client and I need to write cve on TLS =
Key
> > > > > Negotiation Timeout Leading to DoS on 2.4 version
> > > >=20
> > > >=20
> > > > You are free to publish your finding but they do not qualify for a =
CVE
> > > > for two reasons
> > > >=20
> > > > - currently only proven that an EOL version affected
> > > > - the reported behaviour is expected behaviour and we do not see any
> > > > security problems/implication in that behaviour, so no security pro=
blem,
> > > > no CVE.
> > >=20
> > >=20
> > >=20
> > > --
>=20
>=20
>=20
> --
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnOW/aCZBPl5z2a5C4nRYhBAm8PURno41yecVVVU+XnPZr
kLidAADJqgf/fP+US1O0sV88Ui7MjEiaOUPyneyB5A1REmGnON+8Wr1rYngi
EZ+fN/t+ro1F5oVN3r+Y+DrrxQY6sy3C1p62CjcVcu3ogeHtPvpzprcpq6QV
GNl0hp5jg58T7yUyKFD4XPQJoiRBRr4TPnjP8Xa6O3D1KvcU0n22Xa3R/FxC
pCIjeFgcSkqnjrCCmVqQ7cyS4WZ42Sfq1a/ijsq/RWoUX04Afuatyr0qB3fE
EdVUZuzPic0HTA/zrxbnj2Bnv3J05euWROPzVmqpMGqVokKXboN8/N/AyPQb
NZGlV8tierETQvnt/5x6fCM87psCF0K73S8YTbQ/dLfS+7wL2PLlGg=3D=3D
=3Dc6Lz
-----END PGP SIGNATURE-----

--b1=_ERKD6pcjTWOokG3ijbrQyy6LJGE73qjbbVMjxV3t8
Content-Type: application/pgp-keys; name="publickey - tincantech@...2282... - 0x09BC3D44.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4c0JOQkZ2d1NjY0JDQURPbUhF
blFsTG1PakpSdEpMMmw1M01Md3dGVHk3WG5FcHMzYjFRMFV3V1lGQ3YKTDJvTnAwbnJkR2xLS0RK
cTUwWTA5U1IrVVJZQlFtS21ZM0VtenB5VUlLTS9yZ28xUnl1YkhwTVJIYkRwCjdKcDhMeGtmZkZC
VkpqL3Q1Vk1wRDZlTVI2YVVjaVFqZ1JMOE5aZTYrVDd4ZlhYWHdWNWhvUmVaM2pPKwp6SGk2U1I3
eFR2R1hsYStNUXo2RUVwV25sYkx2ZzJvcnQ5S3NldVZqWXJxdlJNeGNkUDBvOWNaV0o1ZXAKSk5t
Z2VCNk03K09XMDhVMVNzWHRLcnBMUmNJNnlLbVYzOGpoelByMlpnUDlybXJsRXJSLzFpcVFRSFhZ
Cm84LzBEZlB5RjBtSDl5blFJaUxFL2wrRll1NHJzRzhWaUtseGhYY3plUHpBdExDamlCMGEwbVJW
QUJFQgpBQUhOTnlKMGFXNWpZVzUwWldOb1FIQnliM1J2Ym0xaGFXd3VZMjl0SWlBOGRHbHVZMkZ1
ZEdWamFFQncKY205MGIyNXRZV2xzTG1OdmJUN0N3SDhFRUFFSUFDa0ZBbHZ3U2NjR0N3a0hDQU1D
Q1JCUGw1ejJhNUM0Cm5RUVZDQW9DQXhZQ0FRSVpBUUliQXdJZUFRQUtDUkJQbDV6MmE1QzRuUUJE
Qi85WlVvOUJPWEpSNjFObQowMm9aLzhhUlhPOU5uVVNGdDZHTE9XY0ROdkFzNElKV01EVkVRZllh
bmIrNDIxUU5kLzVkNkgxaVhGK2kKNExESzBNNmFnQytnc05GSm5qUEdJdHZQdGo3V3lqeW5aUng4
RDQwUFBYaWdmSFl1dzJvUnUwbHIrUDFwCjFxZVVlNE5iY3FJdjhJSXZMejJ6Q2xZWk9OZ0FzUVZj
TkFIaTdaNG9ydFEyaW8yQkFWai84MTlKUFlNdAp0SGdZODF3UzFWN3Y4R0RUWmc4b2FQaFhHZmFD
NFRaRkd0WnIvYnliY3Fyc28zNWphUW1DNTR4TWJYcEYKQVVyYzN1R1ZPSCtPZEcvQlcyZ2NZcXB2
VUZCdWtYeENVQllIUDJOZlhoTmZ6R3Q5bkMxdWxOS1llUDE5ClRHbE9vckJNWUlBRUhvR3h2cGJV
WGZiYU5XQ1V6c0JOQkZ2d1NjY0JDQUM5S3lWWlJTNWFNYUc1UGkwbgpmeDhhTm9zM2JZcDI0Nk10
ZmFvS0JmVFFBcmQrR1pXK1duRnlKRWlTeUxkejByVXV0eUNBZGY1bGdWSCsKV3ZMdkltaUdyU3J6
VnBNVDJuQ1MwOUxxTDUwUWp6OEE3Z3A1SC9oUXp0WjhpTnlzR0Q5Tk80Nk9uSTc1CjkwZEhmQ3JY
alFQU0Z0RkdzVHpnRHhRSWlNdXp6OURSN0Jla0tQbXVPRkloQmU5ZUVacWJ4YzhSV2VRdApoYTdp
L0RySlRSTksxYU9BRFFGVnVWMS9BbTVUaEdQV0ZNL1lKVXlUWWhNVzB5ZVBoNDVPYld1UlFaa3MK
bCthT200TDBLR0REWWxtL0ZReC9FTUN1YnZsenkvenhEZEI2bnFGaWgycVpyZnltbmlTT0thakcw
am9UCnBab3ovRXorNGZBdGc2eTBQc3BOUjZpZEFCRUJBQUhDd0drRUdBRUlBQk1GQWx2d1NjY0pF
RStYblBacgprTGlkQWhzTUFBb0pFRStYblBacmtMaWRSZTBIL2o1Q0lGSUF1Y3VhaUVNa0xrTktF
QU81czd4NDdlTnkKR1BmWnNseVkrSGp6R1UwZDA3TWtrR21Wa1BUVnp3cVZ6Tlpibnk3WkF2MXps
VzBVeTB5SHAxQVBweVl0CjhidVVwcFRCcTdkNDdvZ3hFUll6dC9MYzJMNWEvVktGTlJiaE4xL1hR
bVBpejJFbGU0dHlpcGJUYXBjeQoremJ5ZnpBTUQxM2NJZFoxM2hUc05QMG9sZ0JoQXFVQVVVWXB4
UmxrQUhlSitEdDNOYnpIUzRLUUs1MzgKTkovbDdiWFNLc0dxb1lxSmVaOFZOQnh3V1dVYnVHNGpq
cmg0M01JUmdVWjVXc1BVWVY2SHgwNTZrTWpiCi9iWUJqSTBURU12SDgxNjB1cXpGWGVIdll5VWxx
MFNpbkQvWjlpb0llOFFkc0hHQkRVSVJZWXViMXBPOApxckN6Ulp4MG9OQT0KPS9EZWEKLS0tLS1F
TkQgUEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=

--b1=_ERKD6pcjTWOokG3ijbrQyy6LJGE73qjbbVMjxV3t8
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

wsBzBAABCAAnBYJnOW/aCZBPl5z2a5C4nRYhBAm8PURno41yecVVVU+XnPZrkLidAAAQwQf+K5c+
XbeWQgcvXpVeBSgajjTIgNynUQecK4/tHs535bg2abWivhZQ9f91MoNj2NNNjM70jpncSVEfljN6
AcrX7EjiawzUrCgYlyf4ZBY75dPFdi5PWOYSqt98Koah2HoMyXiWGuVZPHWgJ18vYaSfUtDS2bZS
tCnStKfCKdeXtyGbNSoTbGcl6LM4CePI8mBEcYTxJV6oPhDM9puTR5HD22M0NcZOPehUzAswzKbP
rnrJ7J60YGLw9G63lg2RmLbItXtT/9kqdFHwGM2FXo01ChanvmXjMycuLw745/dDVaP/5iUlz1jh
NpsvV5TFno+64F5l4wSemAn3JT9of8vM7A==

--b1=_ERKD6pcjTWOokG3ijbrQyy6LJGE73qjbbVMjxV3t8--


