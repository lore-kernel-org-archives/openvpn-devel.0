Date: Tue, 18 Aug 2020 21:21:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200818192104.GB75094@...1296...>
References: <CAAWBBYPw=TZg1wftWZL5ABKVWkp7=6hpdaumLN2D24Cgr-E4pQ@...278...>
 <20200818062335.GV75094@...1296...>
 <20200818063212.GW75094@...1296...>
 <CAKuzo_jEGvTnkbsgJVm5beW5SapWoy_xLk_LA+-N59oa6SbbkA@...278...>
 <81A6F618-2F74-417F-A476-BF290CCFF143@...277...>
 <20200818181820.GZ75094@...1296...>
 <2F7C4631-7E3C-47FB-BC8E-E4271F38AD9F@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="udOl8koJG4PSVcOF"
Content-Disposition: inline
In-Reply-To: <2F7C4631-7E3C-47FB-BC8E-E4271F38AD9F@...277...>
Subject: Re: [Openvpn-devel] 2.5-beta-1 Wintun requires SYSTEM privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marvin Adeff <volleynbike@...277...>
Cc: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--udOl8koJG4PSVcOF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 18, 2020 at 12:09:11PM -0700, Marvin Adeff wrote:
> I???m sorry for the confusing response.=20=20
>=20
> Our systems do M2M monitoring and need to run OpenVPN even without a user=
 logged in.  In previous versions we created a script run as a service (as =
SYSTEM) that started OpenVPN (using certificates for authentication).  It a=
lso monitored tunnel status and restarted OpenVPN if necessary.  We never u=
sed the GUI.=20
>=20
> So we are watching how v2.5 develops to know how we will need to implemen=
t the new version.  We are also very interested in seeing what speed improv=
ements wintun will offer.=20
>=20
> I hope that is clearer.=20

Thanks for the clarification.

In that regard, 2.5 will bring no surprises - if you already have SYSTEM
privileges, and do not want/need a GUI, you can "just run OpenVPN" as
you did before.

You can do this with your script, or with the "openvpnsrv2" service,=20
which basically runs openvpn on all config it finds in its config
directory at system startup.  Not sure if these instances get restarted=20
at exit (last time I looked at this was before 2.4.0 release...).

If you already have SYSTEM, accessing wintun from openvpn directly will=20
also work and should bring quite a bit of speed improvement.=20=20

The tricky part is "run from an interactive session" where you can get
Administrator privs, but not SYSTEM (unless you play dirty tricks, which
half the virus scanners out there will flag as "MALWARE!")...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--udOl8koJG4PSVcOF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfPCofAAoJEB2Cnv7KVigSzC0MAJrE55hVegK3LmevSvoO7X0F
yafZTLxAwGuKrdrZ5mrlb/6enx0k2fpqHOgei7Pq1T+cjBnvsVNJqTrlvuaAWOpU
XRxv+0MktgRMcVDbOcULkqTeOoP9Z4d9+7AjLMqHeD6gC8xRz5Mwzfyry+yEoOWx
2aDnO/AwSMYyEwKsxgUCMFjHDBrOJSbJwzxj4Os0DTsaZOhhzQVU3ZxViNU4UfmB
pkZkyAomZS4PNh95DlpEF7Wqn1NnjtUX8SAYHxePcLthUA5g+5p26+FFnQUhydmT
s53Qh9j54e2TPYiknLk41hb/BrlagPnWmg/zO03i9hJBT50AcgB65G22E4uK3z+A
MmcevbqkQ6viSXK56yh75yNq9gP2ZHaKGVgCWPpPFi8S0POShx/VrtfSpmbk8s2w
xKe7XHX7/orkn+vmT/EMg37JNHJRM/ccv2wsbMO6RsyqKoDLMfg45X/sLpqnrucw
SP4tR2I56KrSRANEPYjWVV/6/MNO+C46c7Z6UCKJ8g==
=Bgf1
-----END PGP SIGNATURE-----

--udOl8koJG4PSVcOF--

