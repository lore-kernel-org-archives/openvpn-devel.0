Date: Wed, 22 Oct 2025 21:38:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aPkynAYvOHI587A7@...1296...>
References: <-MNw5Hu8h0rHV18x36ISt7V0UHchIO4i-JoAeV_wlxS1AmDIAe7YVYNput3_r2hiu3HhwxkhGyUhv4-iH_E7mf7nGjvocmGXlDq7Tjly5cE=@joshua.hu>
 <aPfhwvsB8Sk27GME@...1296...>
 <38497401-3a75-4885-8d0f-349c837d14a2@...1227...>
 <aPhx4vGvodCxQ6KW@...1296...>
 <AEnQPdqfGWjCz-mlg3_6apDcIz9cuBUpnlgwt8JdcOmoRUOI0J27hvmUpBBwktUlvL0sZxYIIgJT_q_k06xBnACDnbAPypNjq71D99xtCFM=@joshua.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0WgpI8YPR4EtM0jW"
Content-Disposition: inline
In-Reply-To: <AEnQPdqfGWjCz-mlg3_6apDcIz9cuBUpnlgwt8JdcOmoRUOI0J27hvmUpBBwktUlvL0sZxYIIgJT_q_k06xBnACDnbAPypNjq71D99xtCFM=@joshua.hu>
Subject: Re: [Openvpn-devel] [PATCH] tcp: apply CLOEXEC to accepted socket,
 not listener
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Joshua Rogers <contact@...2949...>
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--0WgpI8YPR4EtM0jW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 22, 2025 at 06:06:21PM +0000, Joshua Rogers wrote:
> By the way, as mentioned, this was found with the ZeroPath tool. I was wo=
ndering if it would be of interest to send the raw results of this scanner =
to somebody that could allow them to review the findings without me manuall=
y triaging? I have done this with curl (https://daniel.haxx.se/blog/2025/10=
/10/a-new-breed-of-analyzers/) and it was quite succesful (~20% false posit=
ive rate).
>=20
> If this is of interest, please let me know where to send them. The output=
 is just markdown, and it includes potential security vulnerabilities. If n=
ot, I will (slowly) continue triaging myself.

This is of interest.

I'm not really sure where to send this - security bugs go to=20
security@...515..., but if it's not security, we should not spam
this list.  Non-security things could go to GH issues, but *if*
there is security relevant things in between, we might want to keep
the lid on it, for the moment...

So you could send everything my way for a start and I discuss with
my co-developers how to do this in the future.  I'll then try to
triage this in a timely fashion and forward to GH, security@, or
just drop :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--0WgpI8YPR4EtM0jW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJo+TKcAAoJEB2Cnv7KVigSNAAL/jeJ2IgzZicS61Kw/5q7tOvK
lUN6OwOVGN14BawsAlP45LQOBgA5E5m0GI0P/pH/ZyZI7RRR0flTChgeRZkzTtAy
AQ2fpQrQJrxa8Nx445Hq0qWk0MxfgKOQT+85zIpjeTq0OAyueUl8Dag2nmp2zhwu
T57tJGhu5xWG8Mj77glLQSIGZbab7eGNlMYVv1eY4xUv1gXmmfo5a5jeyHuagdir
pjJfXZuB1BrAQ9Xc9Rhe7WeWh7j/B4ywLy4DmPMuVhSJNOjEHpJtxB4w/4r+8Rwc
Wm8Lk1R5EEgrGRsEqItHcSp4IX/QQlTYdtLDBefuYtx7ZVtsMoSwhcD3dM0s3tsh
7ojbcsW9V8oIxLBRfsCYPhzSKGlFem/1Z3blxsgv7JibEchSR3eECpFDCQoYKfVf
bUFXF4rdGITBQfK6S8GYEGIvIr81sNImjtltkGTfr+LW9vqDdk6t2revAaKekLT1
TN3SMTIhx1GMBK47GbSzC8W8/ScpdsdO9v5RUTTz5A==
=5EJN
-----END PGP SIGNATURE-----

--0WgpI8YPR4EtM0jW--

