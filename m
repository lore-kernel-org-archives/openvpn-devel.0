Date: Thu, 10 Sep 2020 09:33:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200910073321.GR75094@...1296...>
References: <CAAWBBYMnFOBo4pp_iZ-KnYu7pHbiLqYQJ3rKO1RF+yXcvivgYg@...278...>
 <20200831132357.GZ75094@...1296...>
 <CAAWBBYNLPWmjJ3whY6FAj2G8tT_qkPWZR-gUsKFHe1memta2Og@...278...>
 <CAAF3xa8T=mmZUQdyF3=AZMZZf46TJ85zH=WwAm7ORZiiGGWqZg@...278...>
 <CAKuzo_iTQWBA3t=to4sKdt21pxotNECVfTMFP_fhrEeQ3ejnQQ@...278...>
 <CAAF3xa_Jz1bjw52zBLLdXjgMymk8q+47kt9R8bP8K9Fpt8+s3g@...278...>
 <CAKuzo_jj0SXCVLrthzeCJddK2iKKXAAg4SGTA_pNRXYqcJfTQw@...278...>
 <CAAF3xa-fQ_m=Tow44wqf3DMqWEq9z90n+6Xgg6NvW-UdTaVjHQ@...278...>
 <CAKuzo_gEfixxkFVz3H4myjX9tQAXgGBMpKMJH4fWF2PesHDKDA@...278...>
 <21A02C2A-4FB5-4E3E-9D9C-B09253C9EBD9@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TjyOkJNy6FZ6AD8p"
Content-Disposition: inline
In-Reply-To: <21A02C2A-4FB5-4E3E-9D9C-B09253C9EBD9@...277...>
Subject: Re: [Openvpn-devel] problem with beta3 and wintun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marvin Adeff <volleynbike@...277...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TjyOkJNy6FZ6AD8p
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 10, 2020 at 12:10:25AM -0700, Marvin Adeff wrote:
> Please allow me to back up a moment and restate this:

As a matter of mailing list etiquette - could you please not post
this with

  Subject: Re: [Openvpn-devel] [PATCH] Fix client's poor man NCP fallback

I do try to figure out what is "patch related" and what is "new problems",
and *this* is certainly not related to the NCP PATCH.


> 1.  I installed the beta3 msi from the web site logged in as a user that =
has admin privileges.  But no elevation was used to install it, just double=
-click on the file.=20
> 2.  I only used the GUI as installed, with no elevation, to start OpenVPN=
.=20
> 3.  With TAP selected in my .ovpn config file, everything works normally.=
=20
> 4.  I am reporting that (from the same login) if I change the .ovpn to us=
e wintun (all edits done through the GUI selection), it fails with the erro=
r I showed below.=20

Is the interactive service running?

If tap is used, do you see "routes installed using service" or do you
see netsh commands in the openvpn log?

> Is 4. what you are saying is not supported?  In our use, as we have done =
for the past decade, the client boxes are used for M2M monitoring.  OpenVPN=
 has to connect on bootup (.ovpn config file contains inline certificates) =
regardless if there is a user logged in or not as M2M monitoring occurs in =
the background.  And if a user does login, most often it is with credential=
s that have admin privileges.  I am trying to understand if what you???re t=
elling me is that this will no longer work, or if we will need to do someth=
ing different now?  My testing used the GUI to see how things will work wit=
h wintun so we can continue testing.=20
>=20
> Do I need to NOT use the GUI to get wintun to work?=20=20

Wintun needs SYSTEM privileges.

To get such, you either need to run OpenVPN "at boot" via openvpnsrv2
(which has SYSTEM privileges), *or* you need to use the interactive service
via the GUI.

Due to some Vista-related quirks in the GUI, the GUI will not use the
iservice if it's run elevated (run-as-admin).  If I understand Selva
right, it *should* work if you "just run it", even if the user has
admin privs, as long as UAC is active (as Win10 runs user processes
unprivileged, even if the user is part of the Admin group).


The error message you have posted hints at "the interactive service is
not being used" - which could be due to "it is not running" or "GUI is
running elevated".

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--TjyOkJNy6FZ6AD8p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfWdbAAAoJEB2Cnv7KVigSYMUL/RKAy0mm4iJLSsv2pz+Ul9CI
Sjj71KO7aB8UqYS/x19hnX2GYcD43QV2O+4abBmbWoupXEiLXGM24HXYrdKC94jo
zGIS9UaQOU1l/INpQAMrYGXqlj3WHInguf++4gpc1MEM6TijsiXnwg+YXe9nRvqx
psE1Tq7Hc0xkQCFYO31iXINF8/1FIQ+maEUKYfU9PRqMdRJdW0QAAIFDhoLKg/ZO
4ffet2mlVKob/hMtMUaxyp2raM82wzWgjXlOqWJLGq/SAtMpZYt1RINltiPj7Wc1
E+bAS6DuIubRc5uySiMUuoc3qFPnzcE/bJmGCsJjfbnVCE3gL0VJsTqddqQ034b2
0+ulWO7oL/AAcWUpRSVIsP/MlZ/MfCEcssfswkwivMyBxpjQyMK9wZnVFkcqYkMj
IjwHJTlwpXxWLqJ+FzcfoQeZuUa36T9lMH2/P0WulmjRHSkyc/kLrUTaJXAkH3rG
J44fpnBJi467LVBbmx7oQcxO74k+MmlrAgWyVTk5VQ==
=Gn2O
-----END PGP SIGNATURE-----

--TjyOkJNy6FZ6AD8p--

