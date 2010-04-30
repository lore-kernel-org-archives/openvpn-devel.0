Message-ID: <4BDAEAB9.8080806@...1114...>
Date: Fri, 30 Apr 2010 16:35:37 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BDAD39A.1030906@...515...> <4BDAD611.2000504@...1365...>
	<4BDAD78B.3090805@...515...>
In-Reply-To: <4BDAD78B.3090805@...515...>
Subject: Re: [Openvpn-devel] [Openvpn-users] [TESTING NEEDED] Using
 --inactive and --ping seems to defeat each other
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 30/04/10 15:13, Samuli Seppänen wrote:
> 
>>   On 30-04-10 14:56, Samuli Seppänen wrote:
>>   
>>> Hi all,
>>>
>>> In yesterday's meeting we discussed this issue:
>>>
>>> <http://thread.gmane.org/gmane.network.openvpn.devel/3556>
>>>
>>> In a nutshell, OpenVPN's ping packets (--ping<seconds>) keep the
>>> connection alive even if user uses the --inactive<seconds>  option to
>>> close  inactive connections. Now, the --inactive option has an optional
>>> <bytes>  parameter, which allows closing the connection if less than
>>> <bytes>  of traffic is received in<seconds>. Setting all of these
>>> parameters correctly should allow --inactivity to "ignore" the OpenVPN
>>> ping traffic.
>>>
>>> Has somebody already solved this issue by setting correct values for
>>> --inactive and --ping parameters? Our idea is to change the code so that
>>> the --ping and --inactive options are not mutually exclusive even if the
>>> optional<bytes>  option is not defined.
>>>
>>> I hope I have not been too confusing :). For more information about the
>>> --inactive and --ping options, see "man openvpn" or
>>>
>>> <http://openvpn.net/index.php/open-source/documentation/manuals/69-openvpn-21.html
>>>     
>> I agree that that would be a wise change. However, I wonder: why change 
>> the amount of bytes, if you can also simply not count the ping packets? 
>> To me, it would seem a much more accurate way of determining whether the 
>> connection is idle or not, because there's always the possibility of 
>> duplicate ping packets (even although that's unlikely) or other errors. 
>> Or would that cause a too great load on the server?
>>   
> Sounds like a good idea. Do any devs have an idea how difficult
> (code-vise) that'd be?

I've not gone too deep into this code path yet, but I believe from what
I could see, the byte counter is located on a different place than the
"ping initiator".  That means that telling the "byte counter code" that
"this is our own packet, don't count it" is not as trivial to fix as it
sounds like.

It looks like we just put 16 bytes of "static randomness" (defined in
ping.c) and push that into the some session buffers.  Then later on, in
another function pushes what ever is queued up for transmission.

But this need to be investigated further ... and if someone is quicker
than me to figure it out, patches are, as always, more than welcome!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEUEARECAAYFAkva6rcACgkQDC186MBRfroTcQCeIZTmEXg2zEAtFiF3v0eQsvY/
/nQAlRSsZWXJSlfPT8L5cJT48uwuZm4=
=NuJi
-----END PGP SIGNATURE-----

