References: <20200622113022.23047-1-davids@...515...>
 <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
 <KaDpCcpCdasGfEfmL5ufUPrkbzHJvrlWcm4PCOeWQdCdr8EyRm9Qhtyz6diBZqMpx2S9ipbt7h3xqIvvbOuuv7MVQbsO4EP2fn7_Z8jflg0=@protonmail.com>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ba42f79b-36fc-dd3d-3455-4f08c2557f93@...2080...>
Date: Mon, 22 Jun 2020 19:53:37 +0200
MIME-Version: 1.0
In-Reply-To: <KaDpCcpCdasGfEfmL5ufUPrkbzHJvrlWcm4PCOeWQdCdr8EyRm9Qhtyz6diBZqMpx2S9ipbt7h3xqIvvbOuuv7MVQbsO4EP2fn7_Z8jflg0=@protonmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="3TjohsBAq2RM09bV7i2flGl4Y8IZPj6yh"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?QW5kcsOp?= <pippin1st+devel@...2282...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3TjohsBAq2RM09bV7i2flGl4Y8IZPj6yh
Content-Type: multipart/mixed; boundary="fUuDatRGgjN5qNVRRRp2gMGMKCtECOPbY";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: =?UTF-8?B?QW5kcsOp?= <pippin1st+devel@...2282...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <ba42f79b-36fc-dd3d-3455-4f08c2557f93@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
References: <20200622113022.23047-1-davids@...515...>
 <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
 <KaDpCcpCdasGfEfmL5ufUPrkbzHJvrlWcm4PCOeWQdCdr8EyRm9Qhtyz6diBZqMpx2S9ipbt7h3xqIvvbOuuv7MVQbsO4EP2fn7_Z8jflg0=@protonmail.com>
In-Reply-To: <KaDpCcpCdasGfEfmL5ufUPrkbzHJvrlWcm4PCOeWQdCdr8EyRm9Qhtyz6diBZqMpx2S9ipbt7h3xqIvvbOuuv7MVQbsO4EP2fn7_Z8jflg0=@protonmail.com>

--fUuDatRGgjN5qNVRRRp2gMGMKCtECOPbY
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 22/06/2020 19:20, Andr=C3=A9 via Openvpn-devel wrote:
> Hi,
>=20
>=20
> Sent with ProtonMail Secure Email.
>=20
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Monday 22 June 2020 18:58, Selva Nair <selva.nair@...277...> wrote:
>=20
>> On Mon, Jun 22, 2020 at 7:31 AM David Sommerseth davids@...515... wrote:
>>
>>> This change makes the server use AES-256-GCM instead of BF-CBC as the
>>> default cipher for the VPN tunnel when starting OpenVPN via systemd
>>> and the openvpn-server@...1685... unit file.
>>> To avoid breaking existing running configurations defaulting to BF-CBC,
>>> the Negotiable Crypto Parameters (NCP) list contains the BF-CBC in
>>> addition to AES-CBC. This makes it possible to migrate existing older
>>> client configurations one-by-one to use at least AES-CBC unless the
>>> client is updated to v2.4 or newer (which defaults to upgrade to
>>> AES-GCM automatically)
>>> This has been tested in Fedora 27 (released November 2017) with no
>>> reported issues. By making this default for all Linux distributions
>>> with systemd shipping with the unit files we provide, we gradually
>>> expand setups using this possibility. As we gather experience from
>>> this change, we can further move these changes into the defaults of
>>> the OpenVPN binary itself with time.
>>>
>>> Signed-off-by: David Sommerseth davids@...515...
>>>
>>> ---------------------------------------------------
>>>
>>> Changes.rst | 15 +++++++++++++++
>>> distro/systemd/openvpn-server@...2221... | 2 +-
>>> 2 files changed, 16 insertions(+), 1 deletion(-)
>>> diff --git a/Changes.rst b/Changes.rst
>>> index 00dd6ed8..e76d3c73 100644
>>> --- a/Changes.rst
>>> +++ b/Changes.rst
>>> @@ -14,6 +14,21 @@ ChaCha20-Poly1305 cipher support
>>> channel.
>>> +User-visible Changes
>>> +--------------------
>>> +New default cipher for systemd based Linux distributions
>>>
>>> -   For Linux distributions with systemd which packages the systemd uni=
t files
>>> -   from the OpenVPN project, the default cipher is now changed to AES-=
256-GCM,
>>> -   with BF-CBC as a fallback through the NCP feature. This change has =
been
>>> -   tested successfully since the Fedora 27 release (released November =
2017).
>>> -
>>> -   WARNING This MAY break configurations where the client uses
>>> -                  ``--disable-occ`` feature where the ``--cipher`` has
>>>
>>>
>>> -                  not been explicitly configured on both client and
>>>
>>>
>>> -                  server side.  It is recommended to remove the ``--di=
sable-occ``
>>>
>>>
>>> -                  option *or* explicitly add ``--cipher AES-256-GCM`` =
on the
>>>
>>>
>>> -                  client side if ``--disable-occ`` is strictly needed.
>>>
>>>
>>> -
>>>
>>> Overview of changes in 2.4
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>>
>>> diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/=
openvpn-server@...2221...
>>> index d1cc72cb..f3545ff5 100644
>>> --- a/distro/systemd/openvpn-server@...2221...
>>> +++ b/distro/systemd/openvpn-server@...2221...
>>> @@ -10,7 +10,7 @@ Documentation=3Dhttps://community.openvpn.net/openvpn=
/wiki/HOWTO
>>> Type=3Dnotify
>>> PrivateTmp=3Dtrue
>>> WorkingDirectory=3D/etc/openvpn/server
>>> -ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/status-%i.log=
 --status-version 2 --suppress-timestamps --config %i.conf
>>> +ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/status-%i.log=
 --status-version 2 --suppress-timestamps --cipher AES-256-GCM --ncp-cipher=
s AES-256-GCM:AES-128-GCM:AES-256-CBC:AES-128-CBC:BF-CBC --config %i.conf
>>
>> This is why I keep my openvpn servers out of systemd's view -- it
>> keeps deciding what's good for us. I want to run my configs as is.
>>
>> Selva
>>
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20
> Sorry for the noise in advance but I agree.
> No idea how to keep it out of systemd's view :) but I change the line to
> -ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/status-%i.log -=
-status-version 2 --suppress-timestamps --config %i.conf
> +ExecStart=3D@...2235...@/openvpn --config %i.conf
> and do everything in %i.conf
> No unexpected configuration behaviour that way like missing timestamps in=
 log.

The --suppress-timestamps is actually the _only_ option there which cannot =
be
overridden.  By not having it there, a lot of users would be annoyed by
duplicated timestamps in their logs when they don't use log files directly.
But I can agree, having a way to override this option could be beneficial f=
or
some users.

There might be many reasons why to use separate log files, but on a busy
server it may actually slow openvpn down a little bit (it is still single
threaded and logging happens in the same thread as key negotiations and VPN
network traffic) - especially if file write caches fills up and the fprint()
calls are blocked until file system has synced up.

By default, all logging is easily accessible via 'journalctl -u
openvpn-server@...2562...', where you can do all sorts of filtering (like
--since today or --since yesterday ... and you can pipe it through grep if =
you
want).  The journal also has built in log rotation plus it ensures your file
system will never go completely full (unless you've explicitly disabled that
feature).  Plus it contains a lot more meta-data to use for filtering and
debugging than most other logging systems on Linux these days (try journalc=
tl
-o json-pretty); we don't make use of those features in openvpn 2.x though.

If you do have a syslog daemon running, all logging will normally also go to
the syslog files as well (where rsyslog and syslog-ng allows you to filter =
out
log events from specific servivces to a separate log file, if that's a
requirement).  Most distros also ship with preconfigured log rotation tools,
or the syslog service has that included into the service.

By using the journal or syslog will _not_ block openvpn when it does log
operations.

I can understand if you feel I have this "I know better" attitude here.  I
really don't intend that, but I also do not understand this resistance of n=
ew
tools which can really make your life simpler - if you just care enough to
learn these new tools.  Neither systemd nor the journal are new tools these=
 days.

On the other hand ... this resistance to embrace new tools might also expla=
in
better why some users are still clinging to BF-CBC - *not* saying they are =
the
same persons ... but, as Steffan said in regards to BF-CBC, we need to move=
 on
... also on the tooling around openvpn.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--fUuDatRGgjN5qNVRRRp2gMGMKCtECOPbY--

--3TjohsBAq2RM09bV7i2flGl4Y8IZPj6yh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJe8PAhAAoJEIbPlEyWcf3yNy0P/iKHO+7lazS5WMarM2LeAeOV
RAraRfBg+a3/BTInH52emja2CBkog5xmkSoU/WRBu/tFN3cP3wXufybKPHDghnYQ
H+xPobgRZyeTCBMd6uLl4t1uLMTFr69e5a48zOmiNO4bVBhT+KTQcPI4PCZ249dv
JLhyMVjbFDvaBBF+9OGwsg/dA2vu9KqCUXBqExk4asLZ64egM6XtgNOtFiAiJ9zt
kzpN2K3vPc+fQyGXJj2ejfdM1SVa61iTXfZD0szg1Zs6eFgpTTmd6aE6KjNvSQhz
qgHbYfKs5DSHma8ZIpMGxJmXU0Um9JKlHk1sR2NsvuYdILq99KzLZnsHL4PzMEk8
NUTFCTkQqCEmIL1aqE8uhYCaYOCJcr06e/xbwBG5l6I1V24w01NZtXo0m4NMiGPy
+uinNRNCgcDOMMrxiTAsyBBfTWy4S4bZaZDE0BbRLT46NhHRYpVbFJ/m8Cn3nQyH
+U/csoyZ19J5FTUzOnOUZjacr+IyAe0i+SXIQ6g2tzXBLA+QO4i0103gaHT09pch
gNSmSFhycvPdoj1xP9h6ZIZTZ+qUpNXgu6H2HHdMUXHHFo8mEJU8icOhsKIX0Lp/
zyWuc2/sPC0l6f7sNXHIGR4riUxe6d6mWU5EuKaKG8CwNH/jMeXqZncJZQeJF/0F
i2ZCpU6pyEP1y8bnygQ7
=F5qV
-----END PGP SIGNATURE-----

--3TjohsBAq2RM09bV7i2flGl4Y8IZPj6yh--

