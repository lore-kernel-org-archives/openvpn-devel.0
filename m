From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <b99b879f-d0c1-af75-b2f9-cda3fa5ef526@...515...>
Message-ID: <4997a278-019b-c71e-9b4a-ef569b84e539@...515...>
Date: Wed, 2 Sep 2020 14:07:31 +0300
MIME-Version: 1.0
In-Reply-To: <b99b879f-d0c1-af75-b2f9-cda3fa5ef526@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0HA75tLrZqQdFfyaIHY15nG67pO5HjcNF"
Subject: [Openvpn-devel] Summary of the community meeting (2nd September
 2020)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0HA75tLrZqQdFfyaIHY15nG67pO5HjcNF
Content-Type: multipart/mixed; boundary="2D9hxp56MZR5clDAZFRKesfYUyjlKDB9b"

--2D9hxp56MZR5clDAZFRKesfYUyjlKDB9b
Content-Type: multipart/mixed;
 boundary="------------5960ECAB3B102FE2F8841B61"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------5960ECAB3B102FE2F8841B61
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's the summary of the IRC meeting.

---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wed 2nd September 2020
Time: 11:30 CEST (9:30 UTC)

Planned meeting topics for this meeting were here:

<https://community.openvpn.net/openvpn/wiki/Topics-2020-09-02>

Your local meeting time is easy to check from services such as

<http://www.timeanddate.com/worldclock>

SUMMARY

janjust, lev, mattock and plaisthos participated in this meeting.

---

Talked about OpenVPN 2.5-beta3. There are two known issues it in. The
first one is in the MSI installer:

<https://github.com/OpenVPN/openvpn-build/issues/187>

The second issue manifests itself in the GUI, but is actually tapctl.exe
related (i.e. in the OpenVPN repo):

<https://github.com/OpenVPN/openvpn-gui/issues/359>

These need to be fixed.

--

Janjust noticed that (when using OpenVPN 2.5) Networkmanager is set to
ignore any ipv6 settings yet the default ipv6 route is over the VPN.
This seems like a Networkmanager bug, but janjust will investigate a bit
more.

--

Noted that WolfSSL has not responded to our request to provide an easy
fix and it has been 1.5 months now.

--

Plaisthos is working on implementing peer fingerprinting support. This
will also allow to do quick setup with self-signed certificates without
a CA. Each VPN client will have a fingerprint on the server side, so you
will need to restart the server when you add/remove a client.

--

Full chatlog attached

--------------5960ECAB3B102FE2F8841B61
Content-Type: text/plain; charset=UTF-8;
 name="openvpn_irc_meeting_chatlog_2020-09-02.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn_irc_meeting_chatlog_2020-09-02.txt"

(12:30:56) mattock2: Hi!
(12:32:15) plaisthos: hey!
(12:33:49) janjust_ [~janjust@...1306...:610:120:e034::1001] =C3=A8 entrato nel=
la stanza.
(12:34:23) janjust_ ha abbandonato la stanza (quit: Client Quit).
(12:34:54) mattock2: So: postpone 2.5.0 - thoughts?
(12:35:31) janjust [~janjust@...1306...:610:120:e034::1001] =C3=A8 entrato nell=
a stanza.
(12:35:59) mattock2: There are a few major issues, in openvpn-gui and in =
MSI
(12:36:03) janjust: morning folks... and I immediately see a nicety of op=
envpn+networkmanager ;)
(12:36:43) mattock2: morning!
(12:36:43) lev__: what is GUI issue
(12:36:58) mattock2: second connection fails
(12:37:19) mattock2: can't recall the gui iasue ID
(12:37:20) plaisthos: what is a GUI?
(12:37:24) lev__: ah I think this is not about GUI
(12:37:45) plaisthos: janjust: if we wait for good networkmanager support=
, we can wait another 4 years I guess ;P
(12:37:48) mattock2: yeah  not really, but manifests itself in the gui
(12:37:53) lev__: it is just tap adapters created manually are missing re=
gistry key "allownonadmin"
(12:38:08) lev__: not sure why/how that regressed
(12:38:39) plaisthos: side note: WolfSSL has now been silent for 1,5 mont=
h for the quick fix for their OpenVPN support
(12:40:29) mattock2: yep, I recall we agree to not include wolfssl in 2.5=
 and if they continue silence then throw it out completely in 2.6
(12:40:36) lev__: mattock2: https://community.openvpn.net/openvpn/ticket/=
1321
(12:41:01) janjust: plaisthos yeah I know but I had not expected this: I =
told networkmanager to ignore any ipv6 settings yet my default ipv6 route=
 is over the VPN
(12:41:51) lev__: I can look at it unless somebody fixes it first
(12:41:57) lev__: (allownonadmin)
(12:42:10) mattock2: go for it lev
(12:42:10) lev__: (after fixing/mitigating renaming issue)
(12:43:14) mattock2: +1
(12:46:01) mattock2: anyhow
(12:46:24) mattock2: postponing 2.5.0?
(12:46:28) janjust: just wondering about allownonadmin + openvpn interact=
ive service etc...  does the gui filter any options before passing them o=
n to the iservice?
(12:50:00) lev__: IIRC certain options can only be used by users in Admin=
 group or configs in special place
(12:50:51) janjust: ah good
(12:52:46) lev__: yeah, "/* Authorized group who can use any options and =
config locations */"
(12:53:33) plaisthos: janjust: that sounds more like a networkmanager bug=
 that anything else
(12:54:31) janjust: plaisthos: I agree and I'll need to test it with the =
latest (git) version of networkmanager before I file a bug report
(12:59:56) plaisthos: short status update: I am working on implement a=20
(13:00:03) plaisthos: <peer-fingerprint>
(13:00:06) plaisthos: fp1
(13:00:07) plaisthos: fp2
(13:00:10) plaisthos: </...>
(13:00:20) plaisthos: option to pin certificates of the peer
(13:00:45) plaisthos: This will also allow to do quick setup with self-si=
gned certificates without a CA
(13:05:20) janjust: oh sweet!    more or less the "pre-shared public key"=
 method
(13:06:35) plaisthos: yeah
(13:06:44) plaisthos: and also allows use to deprecate --secret/static ke=
ys
(13:06:57) plaisthos: since from a user perspective it is almost as easy =
to setup
(13:07:31) janjust: throw in TOFU and openvpn is behaving more and more t=
he same as SSH ;)
(13:08:46) plaisthos: TOFU?
(13:08:53) plaisthos: ah trust on first usage
(13:09:04) plaisthos: you will still need to do that manually
(13:09:25) plaisthos: but I am makeing that easy for you since I print th=
e fingerprint of the peer in the error message
(13:13:05) janjust: yeah and with SSH it's the client that needs to trust=
 the server, not vice versa. Question is , does your update include serve=
r-side support?
(13:13:37) plaisthos: yeah
(13:13:44) plaisthos: the same option
(13:13:53) janjust: Nice...=20
(13:14:06) plaisthos: that is also the main reason to allow multiple fing=
erprint
(13:14:11) plaisthos: one for each client
(13:14:25) plaisthos: you will need to restart the server for adding/remo=
ving a client to that list
(13:14:38) plaisthos: but if you need a larger setup without that, you sh=
ould just use a CA
(13:19:38) mattock2: mm
(13:21:29) mattock2: Anything else?
(13:25:22) janjust: don't think so....
(13:28:22) mattock2: Ok, lets end this thing

--------------5960ECAB3B102FE2F8841B61--

--2D9hxp56MZR5clDAZFRKesfYUyjlKDB9b--

--0HA75tLrZqQdFfyaIHY15nG67pO5HjcNF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl9PfPMACgkQKVhNn0CG
RXg4Kwf+OZ0HPHvcxR+l81asVHjCH/aWHqcI6eGawE5Xe4qJAj7GRaJXab3ycvwi
iGEQvsYWxAxGdZ50/ib9pkzaDRvxtvIEnv9dFjZOK/IwtXd1da3nXReN3STr02gU
Sw4KLfLztrUf6EpWwhbU4nEXggVm+eCeAkvVQ2SHltJAPFU/O8WWDd55cwz6ZrCX
TDXzg/H48PYMu5cuZLOmHe2USkkCzfhbGrkRErOHgn4JSq3Fj8gvf8DbCO/ipz11
4viHtg+NUeIoB59SSOttIyDIY4pXZdThK70pyYdVxll/EEHHIbdYwcIfCim1qU2d
b5xSAbXk4LCmRX6VU40Au3H+MqPggw==
=j5GE
-----END PGP SIGNATURE-----

--0HA75tLrZqQdFfyaIHY15nG67pO5HjcNF--

