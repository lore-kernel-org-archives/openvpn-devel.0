Message-ID: <4B8BA877.2000208@...1114...>
Date: Mon, 01 Mar 2010 12:43:51 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <54cde1cd4bdc1e82da3cb67831cc45c0@...1228...>
	<4B8A6E08.3090204@...1114...> <4B8A8401.3050500@...1227...>
	<4B8B941B.7020800@...1114...> <4B8B9EEA.6030209@...1227...>
In-Reply-To: <4B8B9EEA.6030209@...1227...>
Subject: Re: [Openvpn-devel] OpenVPN Pf plugin/small status patch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/03/10 12:03, Arne Schwabe wrote:
>  On 01.03.2010 11:16, David Sommerseth wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 28/02/10 15:56, Arne Schwabe wrote:
>>>   On 28.02.2010 14:22, David Sommerseth wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA1
>>>>
>>>> On 26/06/09 17:00, Arne Schwabe wrote:
>>>>> Hi,
>>>>>
>>>>> I have written a simple plugin for packet filtering that looks up fw
>>>>> rules
>>>>> in the order
>>>>>
>>>>> Commonname.pf
>>>>> IP_Port.pf
>>>>> IP.pf
>>>>> default.pf
>>>>>
>>>>> If one of this files is found the file is used as PF configuration.
>>>>> Maybe
>>>>> this plugin is useful for someone else.
>>>> Hi!
>>>>
>>>> Thank you for your patches.  I've been looking at both patches, and I
>>>> have some questions in regards to this plug-in.
>>>>
>>>> How does this packet filtering further work?  I do not completely
>>>> understand how you imagine this should work.  I see that it tries to
>>>> open a number of files with different filename criteria , and if it
>>>> finds a file it copies it somewhere.
>>>>
>>> The packet filtering itself is already part of openvpn. It only works in
>>> tap mode iirc. See
>>> http://svn.openvpn.net/projects/openvpn/branches/BETA21/openvpn/pf.c. A
>>> description of the packet filter format is given in
>>> http://svn.openvpn.net/projects/openvpn/branches/BETA21/openvpn/management/management-notes.txt
>>>
>>>
>>> COMMAND -- client-pf  (OpenVPN 2.1 or higher)
>>>
>>> This plugin/patch only add the possibility to use the packet filter
>>> functionality without use of the management interface.
>> Thank you for your pointers.  I've been reading the docs and looking at
>> the code.  I'm a bit more informed now.  But there are still some magic
>> here which I don't understand.  How does copying a file enable the
>> packet filtering itself?  Granted the man page and management-notes.txt
>> might be a bit too vague here.
>>
>> man page:
>> -
>> ------------------------------------------------------------------------
>>         --management-client-pf
>>         Management interface clients must specify a packet
>>         filter file for each connecting client.  See
>>         management-notes.txt in OpenVPN distribution for
>>         detailed notes.
>> -
>> ------------------------------------------------------------------------
>>
>>
>> management-notes.txt:
>> -
>> ------------------------------------------------------------------------
>> COMMAND -- client-pf  (OpenVPN 2.1 or higher)
>> - ---------------------------------------------
>>
>> Push a packet filter file to a specific client.
>>
>> The OpenVPN server should have been started with the
>> - --management-client-pf directive so that it will require that
>> VPN tunnel packets sent or received by client instances must
>> conform to that client's packet filter configuration.
>> -
>> ------------------------------------------------------------------------
>>
>> In the docs, "packet filter file" is mentioned, but the docs does a poor
>> job describing all the parts of the feature - which in fact might be
>> /my/ main problem.  It is not described the purpose of this file, except
>> what kind of contents you might find in it and how to understand that.
>> Further, I'm not sure if this should be run on the server or client
>> side, or if it can be used on both sides.  Is this something the server
>> can push to the clients?  It's many loose threads here, which confuses
>> me a little bit.
> As far as I recall correctly the packet filtering code runs *only* on
> the server if the server is in a) multi client mode and b) tap mode. You
> basically can restrict the addresses the clients can reach on a client
> basis. I needed some basic clients are allowd to access internal IP a
> but not b mechanism and the pf code of openvpn was good enough for me.
> But for the simple I did not want to keep another daemon around which
> waits for connecting client and then sends the pf rules so I wrote the
> plugin. That way I could have a default.pf
> 
>> Arne, you patch seems to play inside the defined playground you have
>> available, so I'm not criticising your plug-in here now.  But I need to
>> be able to understand the magic happening here to give your plug-in a
>> fair review.
>>
> Quite understandable.
>> Having that said, the whole packet filtering implementation in OpenVPN,
>> having very good intentions indeed, seems to be rather "hackerish".
>> Just to save the rules in a temporary file (which it looks like it does,
>> according to pf.c:497) seems odd and so un-logic. But that's not your
>> responsibility, Arne :)
>>
>> But if you can please try to enlighten me further, I would appreciate
>> that.  After all, you have a plug-in which solves an issue for you - and
>> I don't want to block your plug-in for inclusion as long as it is
>> considered useful.
> 
> Well the plugin is given a pointer to the temporary file name. If you
> copy a ruleset to that temporary file the openvpn pf filter code picks
> it up. I also think that this api is not the best around but at the
> Moment it is the one a plugin could use. When I wrote the patch, it was
> the least intrusive method to get the pf code working.

Thanks a lot for your time and explanations!  The dots begin to connect
for me, and I begin to see how it works now.  I see a big potential of
improving the internal packet filtering, so this is an invitation to
anyone who got time for that :)

Anyway, back to your plug-in ... if you could shape up those issues I
found in regards to the usage of arrays and improve the buffer overflow
issues I'm willing to include your plug-in.  Also, please go through and
make sure the coding style is coherent and remove not needed functions
as well.  In general we're trying to avoid cleaning up patches after
they are included.

For more information about the development model we're trying to use,
have a look here:

<http://www.secure-computing.net/wiki/index.php/OpenVPN/Developer_documentation>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuLqG8ACgkQDC186MBRfrpTDACdHGKwmeu6fdhWmXj8Xff8Sqzt
yAUAoIkD27Qaq9+OOXWyZUqERAQvWEGr
=MViS
-----END PGP SIGNATURE-----

