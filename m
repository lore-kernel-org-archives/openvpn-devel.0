Message-ID: <4C101F11.9010502@...1369...>
Date: Thu, 10 Jun 2010 01:09:05 +0200
From: Martin Mokrejs <mmokrejs@...1369...>
MIME-Version: 1.0
References: <4BF14A59.2000200@...1369...>	<4C0E6EAB.3040304@...1369...>	<4C0F3F06.2030004@...1114...>
	<4C0F4620.7030100@...1369...>
	<4C0F89D5.6040603@...1147...> <4C100DF0.2050804@...1378...>
	<4C1016CB.3010701@...1114...>
In-Reply-To: <4C1016CB.3010701@...1114...>
Subject: Re: [Openvpn-devel] openvpn-2.1.0-r1: easy-rsa tools creates broken
 client CERTs unusable for TLS
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

David Sommerseth wrote:
> On 09/06/10 23:56, Martin MOKREJ` wrote:
>>   The patches in Gentoo I for example here:

I use Gentoo, I believed that was a "typo" of Jan and did not comment
on that.


>> Please improve the openVPN docs. Further, isn't it possible to
>> provide two openssl.cf files, one for client and the other for
>> server, and fill-in more default values. I never know where to place
>> FQDN, where to place "server", "client", and you saw in my proposed
>> patch that I had to invent even more.
> 
> The documentation needs to be reviewed, to be sure it does provide
> accurate information.  Having that said, it doesn't seem to be that many
> who struggles with this on the ##openvpn IRC channel.  I admit I've not
> paid too much attention to the discussions there the last few weeks, but
> this (VERIFY KU ERROR) is not on the "top 10" trouble list, afaik.

I believe it is an issue. I posted how I generated the certificates and
expect that somebody would have already told me I did answer the questionaree
in a wrong way. For sure, the shell scripts can run something like
"openssl x509 -in cert.crt -text" and verify that the certificate will
be usable for client or server only. The user would not have to transfer it
to the server to realize it is going to refuse it.
Here you can see how I generated the certificates:
http://rt.openssl.org/Ticket/Display.html?id=2268&user=guest&pass=guest
It's too late here but I think instead of teh word "client" I used word
"server". But, if the server key/cert cannot be created by the build-ca
script or sign-req, then we found why I maybe had to tweak the openssl.cf
file. ;-)

My apologies if I followed a wrong manual, I think I followed some on your
site but anyway, I am sure you you check more thoroughly what I did and
make the scripts more fool-proof.

Once I get physically to an old Sun Solaris 2.6 machine I will turn it on
and check that they run smoothly with those "remove bashism" patches. ;-)
In 2-3 weeks.


> But on the other hand, most easy-rsa users do also make use of the
> ./build-key-server and ./build-key{,-pass,-pkcs12} scripts.  It might be
> an issue related to ./sign-req.
> 
> I strongly do not recommend having more openssl.cnf files.  It is
> possible to use one file, which makes the maintenance easier in the long
> run.  The ./pkitool script should take care of providing the needed
> "tweaks" to separate between client and server certificates.

BTW, what I do not like that I have to have write perms into
/some/blah/openvpn/easy-rsa/. It is counterintuitive to have to do as root:

# cd /some/blah/openvpn/easy-rsa/
# ./build-ca

I believe the scripts can be called from any cwd() and the keys/ subdirs
can be made in there. Sure, I have no problem doing
". /some/blah/openvpn/easy-rsa/openssl.cf" before executing
/some/blah/openvpn/easy-rsa/build-ca. ;-) Just some clues.

> 
> For a similar script based version which might work better, take a look
> at ssl-admin <http://www.secure-computing.net/wiki/index.php/Ssl-admin>.

Will look later, thanks.

> 
> 
> I also noticed that Ubuntu was mentioned in the thread.  It might not be
> directly related, but if you have an Ubuntu OpenVPN 2.1_rc7 - rc11
> installation in use, beware that these versions do have some patches
> which makes it incompatible with other versions.  And the failure in
> this case is not obvious.  So, if possible, upgrade to OpenVPN
> 2.1.0/2.1.1 on client and server.

No, as I posted, the only patches applied on my setup were those two,
and the contents of the whole files/ subdir you have just inspected
through some Gentoo mirror.

Time for sleep here, ;-)
Martin

