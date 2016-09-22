References: <4e9afe58-f398-7163-18fe-9113bf0cdfbc@...277...>
	<57E3DF38.7090802@...1147...>
	<82174b6b-9880-45a7-63b0-d8a00c858808@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b7685a16-796f-586b-dc42-c0c9ab36f96d@...2080...>
Date: Thu, 22 Sep 2016 16:54:05 +0200
MIME-Version: 1.0
In-Reply-To: <82174b6b-9880-45a7-63b0-d8a00c858808@...277...>
Subject: Re: [Openvpn-devel] Linux: Use /tmp for log problem ? (solved)
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/09/16 16:06, debbie10t wrote:
> Hi,
> 
> 
> On 22/09/16 14:40, Jan Just Keijser wrote:
>> Hi,
>> 
>> On 22/09/16 15:07, debbie10t wrote:
>>> Hi
>>> 
>>> posting in devel because I am asking for clarification of what
>>> the source code really does.
>>> 
>>> Re: https://forums.openvpn.net/viewtopic.php?f=30&t=22485
>>> 
>>> Config: |--- server *normal stuff* log-append /tmp/openvpn.log 
>>> ---
>>> 
>>> I have just tried with Ubuntu1604 myself and observe that: (My
>>> basic config I added: --log /tmp/client1.log)
>>> 
>>> 1. $ sudo systemctl start openvpn@...2166... = log file *not*
>>> created 2. $ sudo openvpn client1.conf = log file created
>>> normally in /tmp
>>> 
>>> Obviously, systemctl start openvpn@...2166... appends more options
>>> when starting openvpn (in my hand written service the only
>>> addition is --daemon client1) So I presume that by daemonizing
>>> something changes with regard to writing the log file to /tmp
>>> ??
>>> 
>>> Also note, in the forum post --daemon is used within the config
>>> file.
>>> 
>>> I did grep -E "/tmp" src/openvpn/* and found some code in
>>> init.c (line 664) but it's all C, foo, bar to me (Sea food bar
>>> ;-) )
>>> 
>>> Anyhoo, can anybody provide a brief and simple explanation ?
>>> 
>>> Many thanks
>> most likely this , from 'man systemd.exec'
>> 
>> PrivateTmp= Takes a boolean argument. If true, sets up a new file
>>  system namespace for the executed processes and mounts private
>> /tmp and /var/tmp directories inside it, that are not shared by
>> processes outside of the namespace. This is useful to secure
>> access to temporary files of the process, but makes sharing
>> between processes via /tmp or /var/tmp impossible. All temporary
>>  data created by service will be removed after service is
>> stopped. Defaults to false.
>> 
>> 
>> thus, the output *is* logged to /tmp/openvpn.log but the problem
>> is that it's not in the /tmp you'd expect. There's nothing
>> OpenVPN can do about this, it's one of those weird idiosyncracies
>> of systemd.
>> 
>> HTH,
>> 
>> JJK
>> 
>> 
> Thanks JJK, this was *exactly* the problem .. I removed
> PrivateTmp=True from the unit file, (which I had over looked) 
> systemctl daemon-reload and systemctl start openvpn@...2166... and the
> file appeared at /tmp/client1.log

Please do note thate PrivateTmp is considered *security hardening*.
So removing this feature is actually not making things better.  It is
generally far better to put log files where they belong, into /var/log.


- -- 
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJX4/CNAAoJEIbPlEyWcf3ye4EP+wS0yG+ZUC3LjCXARNKvXq19
6jNJf7YBvTtsGt2CjPd9P9xNJ3YphcWh1Nwt2WS0gZJr2asu6E6YINMO6Wk5XM8S
5yW5Gv76BIqq/L+W8VulJ/SQPNC1vNkzyhBnk5TX2dpumGiOhkX9cKUAcnKUOo/6
Z0GCfBka10CfDzr1MgOH7wpaPKqFvAP0Ge+++WnEAIYw06NavaL26mir1/13WLgd
9IuE3zvmZYbjO2SoqX5PR4OYAyMpHdm6il0E/olkSbbSR6K5byzrPEUC34QjzIqp
NL01tQM1TEY8/SSJwi0ZOY0/MHGzrbwDx3E8L0+x2m4qDRnTr9mIsz43y7+kcM93
sy2ZgF8d1nWZ6rm9Dt60fW/Pcvbw+9+EZPXNd+7T9Lb9O2LD9k7iZRpzypC2DRI8
orukpTkmnKzHm4MYEMkYA+LsXihcc00xrNXef7P26BjJIRikYtIytixZtrBGWxae
f+lZr4WLWD1QnaSNMNU2407+beP9htxFOc+BwUcQuDqnaL/cy1rNWg/a7IOFZeDq
RX/WGq6Bg8siUk4D0bP1inT90N5HunOZmwPCiqYhW/s5s9sxh7YG/UZEGZ+iu7/l
dLTzFjrUV/cHEe+boyXs5Zea+09O9AxnZMWFZnr9U4/ek18Kdbl7hLxJTNZb/f/V
9hU+NzEfIGqjb78LYvbI
=EFql
-----END PGP SIGNATURE-----

