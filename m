Message-ID: <4F3970C2.5030000@...277...>
Date: Mon, 13 Feb 2012 20:21:22 +0000
From: Jun Matsushita <junflow@...277...>
MIME-Version: 1.0
References: <4F39094B.7030805@...277...> <4F390B9C.0@...1114...>
In-Reply-To: <4F390B9C.0@...1114...>
Subject: Re: [Openvpn-devel] Obfuscation for Iran SSL blocking
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi David,

I replied to you directly, maybe it got caught in your spam filter?

Anyone else has some thoughts about developing an obfsproxy-style
component for OpenVPN?

Best,

Jun.

On 13/02/2012 13:09, David Sommerseth wrote:
> On 13/02/12 13:59, Jun Matsushita wrote:
>> This is my first post in this list. As probably a lot of you
>> heard, Iran has stepped up its filtering by apparently blocking
>> SSL/TLS using DPI. This is a good read about what's happening 
>> http://news.ycombinator.com/item?id=3575029. As these statistics
>> from TOR attest 
>> https://metrics.torproject.org/users.html?graph=direct-users&start=2012-01-12&end=2012-02-12&country=ir&events=on&dpi=72#direct-users
>
>> 
> 
> the impact has been immediate and surely concerns the majority of
> tools
>> out there.
> 
>> Does OpenVPN allow the use of some form of Obfuscation (such as
>> the one TOR is testing now and seem to work from within Iran 
>> https://www.torproject.org/projects/obfsproxy-instructions.html.en)?
>
>>  Anyone has thoughts about this or would be interested in
>> discussing the matter?
> 
> 
> Hi Jun,
> 
> OpenVPN uses SSL under the hood.  But it does some tricks to allow
> SSL over UDP (SSL is strictly designed for TCP).  This however
> makes some changes that many DPI firewalls *might* not identify
> OpenVPN traffic as SSL traffic.  But as it's not really an
> obfuscation which changes over time, it might still be possible to
> block it if this kind of traffic is detected.
> 
> However, the obfsproxy project sounds very interesting.  And it
> should be possible to use obfsproxy (as it can talk like a SOCKS
> proxy) with OpenVPN, by using the --socks-proxy argument.  But I'm
> not aware of any openvpn services providing obfsproxy services in
> conjunction with OpenVPN.
> 
> 
> kind regards,
> 
> David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPOXDCAAoJECoH9wygNueS5mMH/Rx1IKVJ57Zc5n0l+GVxzdgm
KvS0yt2Su2jD8pyzTujH3CSlCj4n8k7P+NMIN3vTtOfeBWfGhedgi8bQRgEkUB05
oPW/nCK18eRM1uIdBXw/EEudqoHVkBUXzISl04LFLmux7mh7ifGj9sFw/0S2q7mn
Md+qywN0m8+Af5jbQkVkak61lv5H7QK7JNYrFe20+PsV5JhrlZ4xCpJDef3hhGXH
Xl+OGzjv5fqgILOZYbcIWl+tlgNXQP/p/PFi8cmZUvyNV+hq+ACjySn2bDrPzD47
xNF6vXg8wKjYumCZTO2QxVbFPq6oM+3GVxyu6YQCpocPOYACn3ijIrzXUWxzMaM=
=w9je
-----END PGP SIGNATURE-----

