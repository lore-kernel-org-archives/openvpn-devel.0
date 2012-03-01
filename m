Date: Thu, 1 Mar 2012 12:59:11 +0100
From: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <883843028.20120301125911@...449...>
In-Reply-To: <1484458.TVn1BunqfZ@...1526...>
References: <4F4CE4FE.3010009@...515...> <7462163.ufeuZ1iJur@...1526...>
	<1015941915.20120301114051@...449...> <1484458.TVn1BunqfZ@...1526...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
Reply-To: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Heiko Hund <heiko.hund@...1489...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello Heiko,

> Did you try it?

No but I understand the concept of security levels in Windows.
A user can spawn a process with his rights or with lower rights.

>  The service should have sufficient rights to modify it I guess.

No. If you start a process in users context the user can modify it.
There is nothing you could do against.

>> b) dll injection is ONE example of how a user can manipulate his own
>> process. I'm no expert at hacking windows but you can trust me, it
>> exists 1001 possibilities to do the same. You have no chance to block
>> them.

> I file that under FUD until you're more explicit.

I would propose you ask somebody in your company that is experienced
in hacking of windows (maybe someone of the antivir team?)
If a process runs within my security context I can modify it arbitrarily.
That's a very basic concept in operating systems.

I showed you one example how to break your design - injecting a dll.
I'm no expert in hacking processes in windows but from OS design there
have to exists plenty of other ways.

To gave you some ideas, study process hacker.
Try what you could do with your own processes (disable kernel hacker,
otherwise you have full kernel privileges)
http://processhacker.sourceforge.net/
Take a non-admin user, start notepad, start process hacker, go to
properties, view permissions. You could see that on your own process
you have "full control", for example "create thread", "write memory".

greetings
Carsten


