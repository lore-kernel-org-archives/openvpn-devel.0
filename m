References: <1481079112-22990-1-git-send-email-davids@...515...>
	<20161209183724.5c11d987@...1799...> <20161209185926.6bd71feb@...1799...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <dedfa91c-740a-9e87-92ce-dc77a1365df7@...2080...>
Date: Fri, 9 Dec 2016 20:44:00 +0100
MIME-Version: 1.0
In-Reply-To: <20161209185926.6bd71feb@...1799...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="McanjgaFKfBwk4uTh5itWmuCJRPW8Pjs4"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Intermediate --chroot fix with
 the new sd_notify() implementation
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--McanjgaFKfBwk4uTh5itWmuCJRPW8Pjs4
Content-Type: multipart/mixed; boundary="IF7KmetbxPsdfxkKJivnpk9GxSbL1Abei";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <dedfa91c-740a-9e87-92ce-dc77a1365df7@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Intermediate --chroot fix with
	the new sd_notify() implementation
References: <1481079112-22990-1-git-send-email-davids@...515...>
	<20161209183724.5c11d987@...1799...> <20161209185926.6bd71feb@...1799...>
In-Reply-To: <20161209185926.6bd71feb@...1799...>

--IF7KmetbxPsdfxkKJivnpk9GxSbL1Abei
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 09/12/16 18:59, Christian Hesse wrote:
> Christian Hesse <list@...1798...> on Fri, 2016/12/09 18:37:
>> David Sommerseth <davids@...515...> on Wed, 2016/12/07 03:51:
>>> Commit c5931897ae8d663e7e introduced support for talking directly
>>> to the systemd service manager about the situation for the OpenVPN
>>> tunnel. This approach makes a lot of sense and is mostly the proper
>>> way to do it.  But it was discovered that it breaks OpenVPN
>>> configurations using --chroot.
>>>
>>> The reason sd_notify() calls fails when using chroot() is that
>>> sd_notify() expects to have access to a file as declared in the
>>> $NOTIFY_SOCKET environment variable.  It is the main systemd
>>> instance which is responsible to provide both the environment variable
>>> as well as the socket file sd_nodify() should use.  When --chroot
>>> comes into play, the $NOTIFY_SOCKET file will not be available
>>> for OpenVPN any more.
>>>
>>> As things are getting close to the 2.4_rc2 release we will not dare
>>> to bring a too invasive fix.  As well we need some time to discuss
>>> an approrpriate solution.  So this intermediate fix will only
>>> provide a "successful start" message to the systemd service manager
>>> right before chroot() happens.  This will at least resolve the issue
>>> in a safe and non-intrusive way.
>>>
>>> Signed-off-by: David Sommerseth <davids@...515...>
>>> ---
>>>  src/openvpn/init.c | 22 +++++++++++++++++++++-
>>>  1 file changed, 21 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>>> index 74f1139..e47f0d4 100644
>>> --- a/src/openvpn/init.c
>>> +++ b/src/openvpn/init.c
>>> @@ -967,7 +967,27 @@ do_uid_gid_chroot (struct context *c, bool no_dela=
y)
>>>        if (c->options.chroot_dir)
>>>  	{
>>>  	  if (no_delay)
>>> -	    platform_chroot (c->options.chroot_dir);
>>> +            {
>>> +#ifdef ENABLE_SYSTEMD
>>> +              /* If OpenVPN is started by systemd, the OpenVPN process
>>> needs
>>> +               * to provide a preliminary status report to systemd.  T=
his
>>> is
>>> +               * needed as $NOTIFY_SOCKET will not be available inside
>>> the
>>> +               * chroot, which sd_notify()/sd_notifyf() depends on.
>>> +               *
>>> +               * This approach is the simplest and the most non-intrus=
ive
>>> +               * solution right before the 2.4_rc2 release.
>>> +               *
>>> +               * TODO: Consider altnernative solutions - bind mount?
>>> +               * systemd does not grok OpenVPN configuration files, th=
us
>>> cannot
>>> +               * have a sane way to know if OpenVPN will chroot or not
>>> and to
>>> +               * which subdirectory it will chroot into.
>>> +               */
>>> +              sd_notifyf(0, "READY=3D1\n"
>>> +                "STATUS=3DEntering chroot, most of the init completed
>>> successfully\n"
>>> +                "MAINPID=3D%lu", (unsigned long) getpid());
>>> +#endif
>>> +              platform_chroot (c->options.chroot_dir);
>>> +            }
>>>  	  else if (c->first_time)
>>>  	    msg (M_INFO, "NOTE: chroot %s", why_not);
>>>  	}=20=20
>>
>> Looks good to me, so: ACK

Thanks!

>> In long term we should think about a proper solution. Notification socket
>> is /run/systemd/notify, so we would have to make that available from wit=
hin
>> the chroot.
>=20
> BTW, systemd used to use abstract sockets for notifications, which worked=
 with
> processes that chroot themselves. This was changed [0] in favor to
> PrivateNetwork setting. Private network (in terms of systemd) is nothing =
we
> can make use of, though. Obviously... :-p

:)

> Does it make sense to deny to chroot when running from systemd and instead
> add some more security features to the systemd unit? Things like
> ProtectSystem=3Dstrict, ProtectHome=3Dtrue and friends. See systemd.exec(=
5) [1]
> for details.

Yes, I think this can make sense.  I would also like to see more where
things are headed in regards to namespaces (or app-container, if you
want).  If we can also isolate the openvpn process from as much as
possible from the rest of the system (and find a solution for
$HOME/.cert).   But still that does provide some other challenges,
though - like: What to do with script hooks and --plugin files?  And
especially other dependencies of shells/interpretors and shared objects
they may depend on.

Perhaps a discussion we could open up with the systemd team?


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--IF7KmetbxPsdfxkKJivnpk9GxSbL1Abei--

--McanjgaFKfBwk4uTh5itWmuCJRPW8Pjs4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYSwmBAAoJEIbPlEyWcf3yJFoP/39kVOyKAvOWcx/4kBOkDuYn
W6QyaUYH7IoyhdNHG+mB4fffczqb/TJjj0f7rw9B/CPxoTnBXQJIWi8dUURjQkw5
ipXg8qWdAwUnSQHvmXL6mD9jf4y4CswvWqoXa/NZ9yDi0DgpOM+1V7+AI0rAMQsf
At4WpX4/dWeuFgg6SycSkWFZhtC7PmbsA0gu6YXkYw9Q2U6hQFdOvkdGQFfo98jk
dpHZmcEzHRM8RnPEJ2lG72U1UXQMurR4ObH7VvRbKp93Ly8haKfGuepAxnXf0w/u
Q4i3Zu6lZpSEMttFJC2BxlFjMunSDMuD8CXl51040tZ29sDyeSLug12YEY8kyWS6
EIOj4zaQR7UOoL5/jI1oPa2ow6jwvrktBV9ROBpKyhf/AllfSnr8v28FG8aUkBtR
AV2ly6cG59pqT6chieURXU04WQgJczwmEIO5V5LRzEym8uo9ajUlN0L/RnU1tkQ4
E3VIJqHKXw3XrP/+21wcefbJhE6Mx7ScoU5CnmpZRqOBbKLGxmb9ovcLLFb07vFt
N7rE6n1V6TmFoP/kQJ070ue2tYpY9F6kt1grFCqHm9j/DUoGcykhpIZ2BrFewgG8
mAS/16wY8rxUu0l6XrrNefAfkY9xb8xIAm4NVqzNti6oYbMUllRGwa/tgdYDAgGt
2O5MzN7s+0gWOPpwFc0r
=OUvo
-----END PGP SIGNATURE-----

--McanjgaFKfBwk4uTh5itWmuCJRPW8Pjs4--

