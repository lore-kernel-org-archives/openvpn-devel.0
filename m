Message-ID: <4D2D7FDA.50900@...1114...>
Date: Wed, 12 Jan 2011 11:18:02 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4D2C3D0A.2060607@...1114...> <4D2D68E0.9080702@...68...>
In-Reply-To: <4D2D68E0.9080702@...68...>
Subject: Re: [Openvpn-devel] OpenVPN documentation (man page) review
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net, OpenVPN List <openvpn-users@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/01/11 09:40, Matthias Andree wrote:
> Am 11.01.2011 12:20, schrieb David Sommerseth:
>>
>> Hi folks!
>>
>> This is a little cry for help from us playing with the OpenVPN code.
>>
>> We have a quite good man page today with a lot of information.  But
>> maintaining it and to make sure it is up-to-date with all the features
>> OpenVPN supports is often not high up on the priority list.  In
>> addition, the current format (one single file, in pure man page format)
>> is getting harder and harder to maintain as well.
>>
>> So, we're hoping some people with some English skills is interested to
>> help out improving this situation.  What we immediately would like to
>> see is something along these lines:
>>
>> * Move the man page to a better format than the pure man page format.
>>   Are there some good tools/formats like ascii2man or DocBookXML which
>>   could help easing the maintenance of our documentation?
> 
> Docbook XML for sure is a lot more verbose than asciidoc or roff.  I would tend
> to avoid Docbook, the toolchains are lacking a bit -- still :-( although xmlto +
> fop can yield reasonable PDF results.
> 
> However, we should make sure that there still is something that works with "man".

Agreed!  man pages should not go away, that is the main place to find
documentation on the *nix platform.  In fact, in most Linux
distributions it is a requirement to provide man pages to packages there.

But if we could manage to produce, say chm files (or whatever is the
standard nowadays) for windows, that would be a big improvement as well.
 Otherwise, a HTML file (like now, I believe) is better than nothing.

>> * Split up the documentation into more focused sections, like
>>   - main openvpn page (kind of like openvpn.8 today)
>>       Gives an executive overview over OpenVPN, features and references
>>       to the other documentation pages.  A bonus would be if it easily
>>       can produce other formats in addition, like HTML, PS/PDF, ePub.
>>
>>   - openvpn common options
>>       Gives information about the common options openvpn has, which is
>>       useful on both server and client instances.  F.ex. --keepalive,
>>       --tls-auth, --cert, --key, --ca, etc
> 
> Should be part of the main page.
> 
>>   - openvpn server options
>>       Describes only the options which are relevant for openvpn servers
>>
>>   - openvpn client options
>>       Describes only options useful for openvpn clients
> 
> Not sure if that's useful and actually reduces confusion this way.
> 
> Basically what you want is more (a) a concise HOWTO (more or less in place on
> the website), and (b) an exhaustive reference, no?

In the -users mailing list and on the #openvpn IRC channel, it is
obviously that many struggle to find/understand the available
documentation.  OpenVPN is very extensive and flexible, but with that
comes complexity, especially when describing it all at once (like the
man page does).  So this is an area where we should improve.

I believe one of the issues is that a lot of this comprehensive
information is compressed into to few separate files, which can make it
daunting and intimidating really reading the documentation.  Further,
the usage of specific terms might make it more difficult to understand
the document they are reading.  Parts of the documentation do take it
for granted that the reader knows a lot to start with, which often is
not the reality.

Second, maintaining the current man document is a hassle and can be
intimidating for people not having written man pages before.  In
addition, the size of the current man page makes it even more difficult
to make sure it is up-to-date.  Which is also a reason I would like to
split it up into more pieces and a different format than a raw man page
file.

I've taken some of the ideas for categorisation splits from the git man
pages.  It is quite easy to know where to look when you don't know where
to look, and where to look when you know what you are looking for.
That's kind of my main idea.  Further, take out the more advanced things
(like plug-ins) and put the gory details in a separate place, which must
be referenced in the server/client man pages.  This way users will not
be distracted too much with options which are not necessarily related to
what they need or are looking for.

The reason for splitting client and server options is also to avoid
confusion about which options can be used in which mode.  It grouped
correctly in the man page today, but when you scroll up and down in the
man page it is easy to loose overview of which "mode" you are reading about.

I did a quick page count in a 80x25 terminal window for the 2.1.1 man
page.  I lost count when I passed 150 pages.  This is exhaustive, but
easy to loose track of where you are - and might be quite intimidating
for new users.  Therefore I believe splitting it up into more focused
section will be easier for users to understand.

If the "entry" man page also would cover a little bit generic VPN and
networking with VPN basics, referencing other man pages to tools like
ip, ifconfig, route, brctl, etc, it might help new users to understand a
little bit more as well.  Of course, it should not be a "how to
understand TCP/IP routing" document, but clarifying things like "you do
not necessarily need an extra physical NIC when you want to setup VPN",
"Why TUN is preferred over TAP" and similar topics.

Another thing, just as a side note, easy-rsa could really use a man page
as well.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0tf9gACgkQDC186MBRfrqp4QCcCUSX88LCh3/zIrU6nj7HFcsh
PgQAoJQW1XjmZqGC9V3fWnARmCoXxNp8
=3y/+
-----END PGP SIGNATURE-----

