MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Wed, 19 Oct 2022 14:33:27 -0400
Message-ID: <CAKuzo_gRebSz5GObVLJodQvxV2x1XvxFoXoBxe6RuC3fb3eJog@...278...>
Content-Type: multipart/mixed; boundary="000000000000afb54605eb677a9e"
Subject: [Openvpn-devel] Is auth-nocache broken?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000afb54605eb677a9e
Content-Type: multipart/alternative; boundary="000000000000afb54305eb677a9c"

--000000000000afb54305eb677a9c
Content-Type: text/plain; charset="UTF-8"

Hi,

Using --auth-user-pass, --auth-nocache and --reneg-sec <a small value>, no
auth-tokens in use, I see that username/password is prompted on the first
connection attempt and at first renegotiation. After that reneg completes
without prompting for user/pass.

Looking at the server it shows the previously entered password is passed
in.So auth-nocache is no longer effective after the first renegotiation?

A log snippet using a local build that also prints when purge_user_pass()
and get_user_pass_cr() are entered is attached.

After reneg, the client progresses beyond AUTH state (as reported on Trac
#1471 ( https://community.openvpn.net/openvpn/ticket/1471)  which may be
related. Unless it has been like this all along.

Selva

--000000000000afb54305eb677a9c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Using --auth-user-pass, --auth-noca=
che and --reneg-sec &lt;a small value&gt;, no auth-tokens in use, I see tha=
t username/password is prompted on the first connection attempt and at firs=
t renegotiation. After that reneg=C2=A0completes without prompting for user=
/pass.=C2=A0</div><div><br></div><div>Looking at the server it shows the pr=
eviously entered password is passed in.So auth-nocache is no longer effecti=
ve after the first renegotiation?</div><div><br></div><div>A log snippet us=
ing a local build that also prints=C2=A0when purge_user_pass() and get_user=
_pass_cr() are entered is attached.=C2=A0</div><div><br></div><div>After re=
neg, the client progresses beyond AUTH state (as reported on Trac #1471 (=
=C2=A0<a href=3D"https://community.openvpn.net/openvpn/ticket/1471" target=
=3D"_blank">https://community.openvpn.net/openvpn/ticket/1471</a>)=C2=A0 wh=
ich may be related. Unless it has been like this all along.</div><div><br><=
/div><div>Selva</div></div>

--000000000000afb54305eb677a9c--

--000000000000afb54605eb677a9e
Content-Type: application/octet-stream; name="nocache.log"
Content-Disposition: attachment; filename="nocache.log"
Content-Transfer-Encoding: base64
Content-ID: <f_l9fyudfi0>
X-Attachment-Id: f_l9fyudfi0

KGluaXRpYWwgY29ubmVjdGlvbikKCjIwMjItMTAtMTkgMTQ6MTQ6MzYgdXM9MjA3MjUyIE91dGdv
aW5nIERhdGEgQ2hhbm5lbDogQ2lwaGVyICdBRVMtMjU2LUdDTScgaW5pdGlhbGl6ZWQgd2l0aCAy
NTYgYml0IGtleQoyMDIyLTEwLTE5IDE0OjE0OjM2IHVzPTIwNzI2MSBJbmNvbWluZyBEYXRhIENo
YW5uZWw6IENpcGhlciAnQUVTLTI1Ni1HQ00nIGluaXRpYWxpemVkIHdpdGggMjU2IGJpdCBrZXkK
MjAyMi0xMC0xOSAxNDoxNDozNiB1cz0yMDcyNzIgSW4gcHVyZ2VfdXNlcl9wYXNzICA8LS0gdXNl
ci9wYXNzIHB1cmdlZAoyMDIyLTEwLTE5IDE0OjE0OjM2IHVzPTIwNzI3NyBJbml0aWFsaXphdGlv
biBTZXF1ZW5jZSBDb21wbGV0ZWQKCihmaXJzdCByZW5lZykKCjIwMjItMTAtMTkgMTQ6MTU6MzYg
dXM9OTEzMzQ1IFRMUzogc29mdCByZXNldCBzZWM9NjAvNjAgYnl0ZXM9MTMyOC8tMSBwa3RzPTEx
LzAKMjAyMi0xMC0xOSAxNDoxNTozNiB1cz05NDg1NzggSW4gZ2V0X3VzZXJfcGFzc19jciA8LS0g
cHJvbXB0IGZvciB1c2VyL3Bhc3MKCkVudGVyIEF1dGggVXNlcm5hbWU6CkVudGVyIEF1dGggUGFz
c3dvcmQ6CgoyMDIyLTEwLTE5IDE0OjE1OjQ4IHVzPTQyOTk2OCBWRVJJRlkgT0s6IGRlcHRoPTEs
IEM9Q0EsIFNUPSoqKioqKgoyMDIyLTEwLTE5IDE0OjE1OjQ4IHVzPTQzMDA5OCBWRVJJRlkgT0s6
IG5zQ2VydFR5cGU9U0VSVkVSCjIwMjItMTAtMTkgMTQ6MTU6NDggdXM9NDMwMTA3IFZFUklGWSBP
SzogZGVwdGg9MCwgQz1DQSwgU1Q9KioqKioqCjIwMjItMTAtMTkgMTQ6MTU6NDggdXM9NDc0NjIy
IENvbnRyb2wgQ2hhbm5lbDogVExTdjEuMywgY2lwaGVyIFRMU3YxLjMgVExTX0FFU18yNTZfR0NN
X1NIQTM4NCwgcGVlciBjZXJ0aWZpY2F0ZTogMzg0IGJpdCBFQywgY3VydmUgc2VjcDM4NHIxLCBz
aWduYXR1cmU6IFJTQS1TSEEyNTYKMjAyMi0xMC0xOSAxNDoxNTo0OCB1cz00NzQ3NDkgT3V0Z29p
bmcgRGF0YSBDaGFubmVsOiBDaXBoZXIgJ0FFUy0yNTYtR0NNJyBpbml0aWFsaXplZCB3aXRoIDI1
NiBiaXQga2V5CjIwMjItMTAtMTkgMTQ6MTU6NDggdXM9NDc0Nzc3IEluY29taW5nIERhdGEgQ2hh
bm5lbDogQ2lwaGVyICdBRVMtMjU2LUdDTScgaW5pdGlhbGl6ZWQgd2l0aCAyNTYgYml0IGtleQoK
KG5vIHVzZXIvcGFzcyBwdXJnZSkKCihzZWNvbmQgcmVuZWcgYW5kIG5vIHByb21wdCBmb3IgdXNl
ci9wYXNzKQoKMjAyMi0xMC0xOSAxNDoxNjo0OCB1cz0yNTc5NDkgVExTOiBzb2Z0IHJlc2V0IHNl
Yz02MC82MCBieXRlcz0xNDgvLTEgcGt0cz0zLzAKMjAyMi0xMC0xOSAxNDoxNjo0OCB1cz0zMzM1
OTggVkVSSUZZIE9LOiBkZXB0aD0xLCBDPUNBLCBTVD1PTiwgTD0qKioqKioqCjIwMjItMTAtMTkg
MTQ6MTY6NDggdXM9MzMzOTQ1IFZFUklGWSBPSzogbnNDZXJ0VHlwZT1TRVJWRVIKMjAyMi0xMC0x
OSAxNDoxNjo0OCB1cz0zMzM5NzIgVkVSSUZZIE9LOiBkZXB0aD0wLCBDPUNBLCBTVD0qKioqKioq
CjIwMjItMTAtMTkgMTQ6MTY6NDggdXM9MzgyNTM5IENvbnRyb2wgQ2hhbm5lbDogVExTdjEuMywg
Y2lwaGVyIFRMU3YxLjMgVExTX0FFU18yNTZfR0NNX1NIQTM4NCwgcGVlciBjZXJ0aWZpY2F0ZTog
Mzg0IGJpdCBFQywgY3VydmUgc2VjcDM4NHIxLCBzaWduYXR1cmU6IFJTQS1TSEEyNTYKMjAyMi0x
MC0xOSAxNDoxNjo0OCB1cz0zODI2MjQgT3V0Z29pbmcgRGF0YSBDaGFubmVsOiBDaXBoZXIgJ0FF
Uy0yNTYtR0NNJyBpbml0aWFsaXplZCB3aXRoIDI1NiBiaXQga2V5CjIwMjItMTAtMTkgMTQ6MTY6
NDggdXM9MzgyNjQ2IEluY29taW5nIERhdGEgQ2hhbm5lbDogQ2lwaGVyICdBRVMtMjU2LUdDTScg
aW5pdGlhbGl6ZWQgd2l0aCAyNTYgYml0IGtleQo=
--000000000000afb54605eb677a9e--

