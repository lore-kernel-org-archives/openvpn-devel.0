Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170906235202.26551-1-davids@...515...>
 <20170907061646.GD70062@...1296...>
 <79762b44-c8c8-b765-1711-22ba3f210af0@...515...>
 <1e1b1ed5-5a4e-5234-1e57-06a609a6f2b9@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <7d8b3364-b806-e21a-7772-06fa1eedb4ad@...2080...>
Date: Thu, 7 Sep 2017 15:00:34 +0200
MIME-Version: 1.0
In-Reply-To: <1e1b1ed5-5a4e-5234-1e57-06a609a6f2b9@...515...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="puC7NXEPvqsTwdn9uR6pQ2A0C11a5bd88"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--puC7NXEPvqsTwdn9uR6pQ2A0C11a5bd88
Content-Type: multipart/mixed; boundary="0VUjQNWitXARTxP5pRqbNppCmPdnnErgV";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
 Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <7d8b3364-b806-e21a-7772-06fa1eedb4ad@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
References: <20170906235202.26551-1-davids@...515...>
 <20170907061646.GD70062@...1296...>
 <79762b44-c8c8-b765-1711-22ba3f210af0@...515...>
 <1e1b1ed5-5a4e-5234-1e57-06a609a6f2b9@...515...>
In-Reply-To: <1e1b1ed5-5a4e-5234-1e57-06a609a6f2b9@...515...>

--0VUjQNWitXARTxP5pRqbNppCmPdnnErgV
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 07/09/17 10:04, Samuli Sepp=E4nen wrote:
> On 07/09/2017 10:16, Samuli Sepp=E4nen wrote:
>> On 07/09/2017 09:16, Gert Doering wrote:
>>> Hi,
>>>
>>> On Thu, Sep 07, 2017 at 01:52:02AM +0200, David Sommerseth wrote:
>>>> @@ -18,6 +18,8 @@ DeviceAllow=3D/dev/net/tun rw
>>>>  ProtectSystem=3Dtrue
>>>>  ProtectHome=3Dtrue
>>>>  KillMode=3Dprocess
>>>> +RestartSec=3D5s
>>>> +Restart=3Don-failure
>>>
>>> Is there a way to get exponential backoff on restart?
>>>
>>> Restarting is good, but if there is something faulty that leads to
>>> "the process always dies right away", this can lead to very quickly
>>> filling disks with not-so-useful logging...
>>>
>>> (Otherwise, yes, restarting is good :-) )
>>>
>>
>> Hi,
>>
>> From systemd.unit man-page[1]:
>>
>>   StartLimitIntervalSec=3D, StartLimitBurst=3D
>>
>>     Configure unit start rate limiting. By default, units which are
>>     started more than 5 times within 10 seconds are not permitted to
>>     start any more times until the 10 second interval ends.
>>
>> I verified this behavior on CentOS 7 using another daemon (monit) by
>> setting "Restart=3Don-failure" for it, breaking its config file and
>> forcibly killing it. Note that RestartSec is the default, i.e. 100ms:
>>
>> ---
>>
>> Sep 07 09:55:37 centos-7 systemd[1]: monit.service: control process
>> exited, code=3Dexited status=3D1
>>
>> Sep 07 09:55:37 centos-7 systemd[1]: Unit monit.service entered failed
>> state.
>>
>> Sep 07 09:55:37 centos-7 systemd[1]: monit.service holdoff time over,
>> scheduling restart.
>>
>> Sep 07 09:55:37 centos-7 systemd[1]: Stopping Pro-active monitoring
>> utility for unix systems...
>>
>> Sep 07 09:55:37 centos-7 systemd[1]: Starting Pro-active monitoring
>> utility for unix systems...
>>
>> Sep 07 09:55:37 centos-7 systemd[1]: monit.service start request
>> repeated too quickly, refusing to start.
>>
>> Sep 07 09:55:37 centos-7 systemd[1]: Failed to start Pro-active
>> monitoring utility for unix systems.
>>
>> Sep 07 09:55:37 centos-7 systemd[1]: Unit monit.service entered failed
>> state.
>>
>> ---
>>
>> As you can see, systemd quickly realizes that monit will not come back
>> up and stops trying.
>>
>> However, when I added "RestartSec=3D5s" the StartLimit* thresholds were
>> never triggered. This meant that systemd never ceased trying to restart
>> the monit service.
>>
>> David: any particular reason why you added RestartSec? Why not just let
>> it be the default (100ms)?

Partly to avoid respawning too fast.  We don't know what kind of
additional plug-ins or management interface tools have been integrated
and how they react if OpenVPN goes into a tight restart-loop.  And
partly to _escape_ the stopping of restarts.

I'm not sure I'm easily buying into the "faulty configuration" argument.
 Because these restart scenarios mostly happens when a sys-admin is
_not_ around.  If you're playing with configurations, do a restart to
test the new config, you are around to handle a failed situation.  The
only area where this can fail is when we break options and OpenVPN get
updated automatically.  But in both these scenarios, a restart delay of
5 seconds won't cause too much stress on the system.

I also opted for not much longer delay, as if a restart happens
successfully, most users won't notice that too much.  If it is 30
seconds or 1 minute, that is much more noticeable.  But I'm open for
adjusting this too.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--0VUjQNWitXARTxP5pRqbNppCmPdnnErgV--

--puC7NXEPvqsTwdn9uR6pQ2A0C11a5bd88
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZsUL5AAoJEIbPlEyWcf3yAQgP/1pOrE1I3mW54zxJdZ6HTXtv
hQ0hRsn47hfKu1AHN2oeX65ZJb0ao6QlJ56oJNUgmSOnnKi4eVHZzUv2e6dZLXFx
dg1f15fVIlyjLSy7UOIpvOUHRXAiLwfkFa/FsbQtP/rn7IuZQGC9HODW7+LDpmyl
ckbbQA+n6dDeGkkx0oiC07yBXtAKQc2CBakBwjp84c3TaWKBZvAZyfKULEMM9idR
ZykdiqUz1ovCaSOm9mDne7/TBH4iHpL9c4ZKwjnhdRcuO1zk0ZUMHEU1xmyfmBnI
eeG0zi27tYqqIWYU7AE+utj0WdvJFkDCVTkyOPdVeOXKp3gcA1l66jsqduXIexeo
Icx0GFm33xBWlVBJfRu8ZTjQi7s60hLXDe9LxyFYJWqI/DmEF/dgVEJR5uHt5TNc
DMT7n9RlocxYPe/DjAbJsASuN3uCiwX2YoqQWjqAWtC48sbul8wi7isUv6F8oqd6
fEB80jGzfzbC4dYsKGWMuwqcV0N/WzE0AVKY2XV4lTpnD4CN28NQo812A2AKfmF4
OD+nR4seG7M5bPbDNA4prRa6zIczPIr4MtsZL4bDTE0gAsAPgIaxpQHgKt7DNH8L
fufIaXP7lxTZ6n8A3aL/QitlpatTjet/D24u4tkdMRSx6cM1/4ijpHlmlyovB3cI
DIYAzf9G+M+d7MDddjCI
=/pnu
-----END PGP SIGNATURE-----

--puC7NXEPvqsTwdn9uR6pQ2A0C11a5bd88--

