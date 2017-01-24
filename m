References: <20161227221539.329-1-list@...1798...>
	<20161227221539.329-2-list@...1798...>
	<bfee252f-300d-299c-89e9-197d1cd7b3fc@...2080...>
	<20170124153647.5510c8a5@...1799...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <15f1a570-92ae-79cc-662a-77ddbdcb0aec@...2080...>
Date: Tue, 24 Jan 2017 16:11:33 +0100
MIME-Version: 1.0
In-Reply-To: <20170124153647.5510c8a5@...1799...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="NKRFPelK7ruTkPRmoodXGMXmeF22udQpm"
Subject: Re: [Openvpn-devel] [PATCH 2/2] do not race on RuntimeDirectory
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>
Cc: Christian Hesse <mail@...1798...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NKRFPelK7ruTkPRmoodXGMXmeF22udQpm
Content-Type: multipart/mixed; boundary="GpvK8tqGImIjGWIqah9Gp8N96R9UmIu52";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>
Cc: openvpn-devel@lists.sourceforge.net, Christian Hesse <mail@...1798...>
Message-ID: <15f1a570-92ae-79cc-662a-77ddbdcb0aec@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] do not race on RuntimeDirectory
References: <20161227221539.329-1-list@...1798...>
	<20161227221539.329-2-list@...1798...>
	<bfee252f-300d-299c-89e9-197d1cd7b3fc@...2080...>
	<20170124153647.5510c8a5@...1799...>
In-Reply-To: <20170124153647.5510c8a5@...1799...>

--GpvK8tqGImIjGWIqah9Gp8N96R9UmIu52
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 24/01/17 15:36, Christian Hesse wrote:
> David Sommerseth <openvpn@...2080...> on Fri, 2017/01/20 21:55:
>> On 27/12/16 23:15, Christian Hesse wrote:
>>> From: Christian Hesse <mail@...1798...>
>>>
>>> Different unit instances create and destroy the same RuntimeDirectory.
>>> This leads to running instances where the status file (and possibly
>>> more runtime data) is no longer accessible.
>>>
>>> So do not handle this in unit files but provide a tmpfiles.d
>>> configuration and let systemd-tmpfiles do the work.
>>> Nobody will (unintentionally) delete the directories and its content.
>>> As /run is volatile we do not have to care about cleanup.
>>>
>>> Signed-off-by: Christian Hesse <mail@...1798...>
>>> ---
>>>  configure.ac                              | 8 ++++++++
>>>  distro/systemd/Makefile.am                | 8 ++++++++
>>>  distro/systemd/openvpn-client@...2221... | 2 --
>>>  distro/systemd/openvpn-server@...2221... | 2 --
>>>  distro/systemd/openvpn.conf               | 2 ++
>>>  5 files changed, 18 insertions(+), 4 deletions(-)
>>>  create mode 100644 distro/systemd/openvpn.conf
>>>=20=20=20
>>
>> [...snip...]
>>
>>> diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
>>> index 53a88c9..1a6c974 100644
>>> --- a/distro/systemd/Makefile.am
>>> +++ b/distro/systemd/Makefile.am
>>> @@ -12,7 +12,12 @@
>>>  	$(AM_V_GEN)sed -e 's|\@sbindir\@|$(sbindir)|' \
>>>  		$< > $@.tmp && mv $@.tmp $@
>>>=20=20
>>> +install-data-local:
>>> +	$(INSTALL) -d -m0710 $(DESTDIR)/run/openvpn-client
>>> +	$(INSTALL) -d -m0710 $(DESTDIR)/run/openvpn-server=20=20
>>
>> Hmm ... that doesn't make much sense, does it?
>>
>> $ mount | grep '/run '
>> tmpfs on /run type tmpfs (rw,nosuid,nodev,seclabel,mode=3D755)
>>
>> IIRC, upstream systemd recommends /run to be a ramdisk, as it should
>> always be clean on freshly rebooted systems.  And it probably saves a
>> lot of SSD/flash storage write cycles, for those using that.
>=20
> Well, the idea is: Files in /usr/lib/tmpfiles.d/ are handled by
> systemd-tmpfiles at boot time. We want these directories after installati=
on
> (without a reboot) to be present - so just create them. Yes, these reside=
 on
> tmpfs, but are created automatically after reboot.
>=20
> As package managers should run a hook if files in /usr/lib/tmpfiles.d/ ch=
ange
> (pacman does now) I am fine with removing this rule.
>=20
> People installing manually may still stumble on this...

Ahh I see.  I've not done any 'make install' on my systems for years; I
build proper packages through mock/rpmbuild and install those.  So much
of that magic happens there.  And I believe rpmbuild can complain loudly
if it tries to own directories on a tmpfs.

Okay, I'll ponder a little bit on this one and see what others do as
well.  You do have a valid point where users run 'make install' on a
"production box".

>> [...snip...]
>>
>>> @@ -21,6 +26,9 @@ systemdunitdir =3D $(systemdunitdir)
>>>  systemdunit_DATA =3D \
>>>  	openvpn-client@...1685... \
>>>  	openvpn-server@...1685...
>>> +tmpfilesdir =3D $(tmpfilesdir)=20=20
>>
>> This conflicts with AC_SUBST([tmpfilesdir])
>>
>> $ autoreconf -vi
>> autoreconf: Entering directory `.'
>> autoreconf: configure.ac: not using Gettext
>> autoreconf: running: aclocal -I m4
>> autoreconf: configure.ac: tracing
>> autoreconf: running: libtoolize --copy
>> autoreconf: running: /usr/bin/autoconf
>> autoreconf: running: /usr/bin/autoheader
>> autoreconf: running: automake --add-missing --copy --no-force
>> distro/systemd/Makefile.am:28: warning: tmpfilesdir was already defined
>> in condition TRUE, which includes condition ENABLE_SYSTEMD ...
>> configure.ac:1293: ... 'tmpfilesdir' previously defined here
>> autoreconf: Leaving directory `.'
>> $ rpm -q autoconf
>> autoconf-2.69-11.el7.noarch
>>
>> Removing that tmpfilesdir declaration line in Makefile.am resolves this
>> issue, and it still works as expected.
>=20
> Removed.
>=20
>> [...snip...]
>>
>>> diff --git a/distro/systemd/openvpn.conf b/distro/systemd/openvpn.conf
>>> new file mode 100644
>>> index 0000000..57f20cd
>>> --- /dev/null
>>> +++ b/distro/systemd/openvpn.conf
>>> @@ -0,0 +1,2 @@
>>> +d /run/openvpn-client 0710 root root -
>>> +d /run/openvpn-server 0710 root root -
>>> \ No newline at end of file=20=20
>>
>> This makes more sense though, as this will tell systemd to create these
>> directories with the proper attributes.
>>
>> But I'm not too happy about the filename in our git repository.  The
>> destination file may very well be called openvpn.conf, as then it should
>> reside in $libdir/tmpfiles.d/ ... but openvpn.conf causes quite a bit of
>> ambiguity inside the openvpn source tree, and unaware users might more
>> see this as a sample configuration for OpenVPN and be even more confused.
>>
>> I propose ... either rename this file to tmpfiles.d--openvpn.conf or
>> move this openvpn.conf inside a tmpfiles.d/ subdirectory inside the
>> ./distro/systemd/ directory.
>>
>> Otherwise, this looks very reasonable.
>=20
> Reworked this... Are we ok renaming the file in automake target
> install-data-hook? Could not come up with a better solution.

Perhaps using a tmpfiles.d/ subdir inside distro/systemd is cleaner then.

> I will send an updated patch soon.

Thanks!


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--GpvK8tqGImIjGWIqah9Gp8N96R9UmIu52--

--NKRFPelK7ruTkPRmoodXGMXmeF22udQpm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYh26lAAoJEIbPlEyWcf3yITMP/1bnp55q03iee6yykx4leFe0
EgIWJjyy0jSzkA3oEe+22bkXaW4T0x90+IXkYjfP7fxESTu1zne7iDj3AjUC8/Yj
6BNBOXktaJtDFevy5BXTf9QeHVmXO4A51j04MBWN0kh76wWPvk+G+iHfG4W0CVhb
pmMOyR3D50b/NNbMiGLpNmg/4IXak52OpAvHPzBi0wrR2yoqtm8K0kf2ciJj8iW+
mN08gGut+pYalOCi/JDgKJrJVimXZpiX2e0WTlwPkP7pI7y7Yk/NEEo5LL8vf7WX
RyJR/+4P/kfqfGzNgTeM3xXkIg51wtOBubHAjlmjy6Dstuvtmg8Yfmd5Dp/rGE/r
k0lrUnMr+MYBmfu04iyU//hJkd9Yq0IBu2GPoICkaHC6emk4jnsiGHKj0ebPS10f
wntK5gGokqmPT2Kbb7S/S05qDL3CXrK6k/dwUrMG2coyiK0OOWvLo3OIdQDhD9yK
SDn50Igr97Gf1xo5LT7bsDomI2DWp3J0BDDkFeZu8dXiXmDqg3HlT2ljeYaJpfwM
SAHME4/22BhBCGgb+3SSCkosDE1iKKOfLBZp6DOkItW4axCDQV5BHTWCAZvqgUNY
ThkTcwyofJWdBwLnmqaIdL6RzK8A8Ypufp5l8AQ5R1+h8Y24pQXK3YQp9R637n0t
ADGkdMWHYl8lEC8EaVn3
=L5Ei
-----END PGP SIGNATURE-----

--NKRFPelK7ruTkPRmoodXGMXmeF22udQpm--

