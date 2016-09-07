References: <834c4ed9-af60-1f0b-091d-da0fafa6bd96@...2080...>
	<dcc82a0c-97fb-03bc-b1f6-5e39bbc7ecde@...2080...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <56260bca-39bf-cd7f-734f-f9df4063a5ff@...2080...>
Date: Wed, 7 Sep 2016 20:57:07 +0200
MIME-Version: 1.0
In-Reply-To: <dcc82a0c-97fb-03bc-b1f6-5e39bbc7ecde@...2080...>
Subject: Re: [Openvpn-devel] Modernising the management interface
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
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/09/16 19:28, David Sommerseth wrote:
> On 31/08/16 20:55, David Sommerseth wrote:
> 
>> Hi,
> 
>> I have for a long time pondered on how we can make the management
>>  API more suitable for more modern tools and tasks.  So I am just
>>  giving an extremely early heads-up on on what I'm poking at ... 
>> and hopefully receive some feedbacks on what you think.
> 
>> One of the things which have struck me is that D-Bus is adopted a
>>  lot of places, and its internal API have been considered stable 
>> for about 10 years or more.  Even though there are areas where 
>> D-Bus seems a bit over-engineered, it has proved to be a very 
>> useful IPC mechanism for a lot of software.
> 
> [...snip...]
> 
> Time for some proof-of-concept code!
> 
> <https://gitlab.com/dazo/openvpn-dbus-poc/tree/master>
> 
> This is just a plain and silly TCP management to D-Bus proxy.  It 
> does nothing fancy, but it is just a little introduction to how 
> D-Bus can simplify getting an integration to a management
> interface in OpenVPN.
> 
> To do the more advanced features, such as signalling ("push"
> messages from server to listening D-Bus clients) is something which
> will require a lot more work and I have not considered doing this.
> 
> All information to get started should be fairly well documented in
> the source code.  But if anyone have any questions, no question is
> too silly .
> 
> A few details.
> 
> - *DO NOT RUN THIS IN PRODUCTION!*  This is *Proof of Concept*
> code. It will be buggy, it is hacky and you cannot fully trust it.
> 
> - A proper implementation will not use Python on the D-Bus server
> side, but will be included into the core OpenVPN C code.
> 
> - A proper implementation will also use "properties".  This is 
> currently not possible to do via the dbus-python implementation,
> at least not without too much additional hackery.  For a PoC, I did
> not consider this important.  But a proper implementation in C will
> make use of object properties to provide read-only information.
> 
> - The API provided via the D-Bus by this proxy WILL change.
> 
> - Please do not start massive improvements to this code, unless it
> helps understanding better D-Bus features which can be worth 
> investigating further.
> 
> Again: A proper D-Bus server implementation will happen inside the
> OpenVPN C code.  This code is purely to help us getting further in
> this discussion.
> 
> - And please do not judge the code harshly.  I have prioritised 
> getting something which works for a PoC.  I have not added much 
> styling or very describing comments.  And yes, there will be bugs.

Just for reference (or "fun"), I did a very quick and dirty port of
the Python client to Perl ... for all of the Perl fans out there.
That code is horrible, as I've not done any Perl coding for almost 9
years (it seems I've recovered after all those years ;-)).  But once
you've installed the Net::DBus package it should work.  It is located
in the same git repository as the python code.


- -- 
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJX0GMDAAoJEIbPlEyWcf3yjX4P/jtFYvK1VIThayYcs9rtYMQc
gLv7G/PgfltiWrSRItmDu6xahJGte8akghDni1VClmY9d6r5lsYtId6QnlqoijlR
o+Z6W7b1IenB0LRj2q2w3gJcc7XL+2rDkwSOu7Nqw+dFSmDdrA85TFCk55l6gucX
elvhP4svn5/BTUXWu1PvceVrGiqA74XwE4HB+C+4xL7/j4TeybBxrXR5MWJSAteC
9njH6yqzU2r89c0biRYwVLDiO1XBBDIGM6osYwupO24PDeG82Vbtjb/GI4bF+dIo
t0DfcuPpKqZYlkiDFQeDcfmt+3H1XEmhkDzeV3UmMhK5TvY8oZVq9ZMHJLFUTbDY
M0qnJf7wVykebBctoLujaEl6IhclQKinq4ywQ7LnVXDwQrIubF07VowoOH4qDGY7
MPfn5Oq0qb+dL1bfB4lJbuK5A20ezQAslh5UqjhktDej9RXQu0F8C1N1H0psJRjE
+JPgtxTsQvh0RmzhJtQv30dqcO8XFgDLK5tJ3GPJTuM1+nh76OYYjnewonr+AfQI
pSx4UsG1B2RI7BGVcgr/1dfmkaxc4fvAVaBdtlXddnD2RgCPYjN6iBnPojQ56JNp
zzLAtGPCPrr4Gb6L5Ulg1xZPPvhMZLaFx/SeKFETj/3Vf1llNqiMSCARJ30966tW
DHetuWrI08j0Pi8JG7r9
=llV3
-----END PGP SIGNATURE-----

