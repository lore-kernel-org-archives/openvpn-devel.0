Message-Id: <55BD8DBD-8E0F-45BD-96CB-EF3DD520726D@...1348...>
From: Toby Thain <toby@...1348...>
In-Reply-To: <201006052252.56680.dave_br@...1278...>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Sun, 6 Jun 2010 08:39:41 +1000
References: <20100604224938.GA19956@...1375...>
	<201006052125.38352.dave_br@...1278...>
	<4C0ABFFF.6060809@...1114...>
	<201006052252.56680.dave_br@...1278...>
Subject: Re: [Openvpn-devel] PATCH: remove bashisms from easy-rsa
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net


On 6-Jun-10, at 7:52 AM, Davide Brini wrote:

> On Saturday 05 June 2010, David Sommerseth wrote:
>
>> Yes, that can be seen as a solution for some people.  But then it  
>> would
>> be better for us to explicitly require the needed shell rather to  
>> tell
>> them to (w)hack their system "because easy-rsa don't support old  
>> Solaris
>> /bin/sh".
>>
>> We should *never ever* recommend people to modify their OS base
>> installation at any point to make OpenVPN and/or its utilities to  
>> work.
>> In fact, it's probably more likely that they would go in and modify  
>> the
>> shell script themselves to use the proper shell instead of re-link
>> /bin/sh - at least I hope the sys-admin would be that clever.
>
> Ok, I wasn't aware of this policy. I thought that it could just be  
> stated that
> the scripts need a POSIX shell (just as it's *already* de-facto  
> stated that
> they require bash, which is not installed on all systems).
> But ok, I'm not arguing on this; as you said, interested people will  
> probably
> be able to adjust them to their needs anyway.
>
>> [snip]
>
>>> However, I think it would be sensible, before merging, to actually  
>>> do
>>> that and test the scripts on a real Solaris system to check that  
>>> they
>>> work as expected (unfortunately I don't have access to a Solaris  
>>> system,
>>> otherwise I would do that myself).
>>
>> The Solaris 10 docs states it pretty clear:
>>
>>  -e file
>>      True if file exists. (Not available in sh.)
>>
>> This limitation is also for -a, -G, -o, -O, -S, -nt, -ot and -ef.
>> source: <http://docs.sun.com/app/docs/doc/816-5165/test-1? 
>> l=en&a=view>
>>
>> And there are 3 places where we do use 'test -e' in easy-rsa-2.0:
>>
>> nherit-inter:29:    if [ -e "$1/$EXPORT_CA" ]; then
>> pkitool:371:		[ -e "$FN.crt.der" ]; rm "$FN.crt.der"
>> revoke-full:29:    if [ -e export-ca.crt ]; then
>>
>> We simply need to solve these issues to avoid bashism.
>
> Even after doing that, we're still NOT guaranteed that the scripts  
> will work
> with Solaris' default /bin/sh. There may still be other constructs not
> supported by Solaris' default /bin/sh.
>
> Solaris' default /bin/sh is NOT a POSIX shell; it's an old Bourne  
> shell, which
> I'm not familiar with except for knowing that many things I and most  
> people
> are used to are not supported (I don't know exactly what these missing
> features are, although it should definitely be possible to find out).
>
> For the case at hand, I'd say it could be enough to replace "test - 
> e" with
> "test -f", since we're testing for files anyway:
>
> -e  pathname
>    True if pathname resolves to an existing directory entry. False if
>    pathname cannot be resolved.
>
> -f  pathname
>    True if pathname resolves to an existing directory entry for a  
> regular
>    file. False if pathname cannot be resolved, or if pathname  
> resolves to an
>    existing directory entry for a file that is not a regular file.
>
> This description is for a POSIX shell; -f should be supported by the  
> Bourne
> shell, as it's not in the list you quoted above. However, I don't  
> know it the
> Bourne shell's semantic for -f is the same as POSIX's. I think it  
> should be
> similar or equal.
>
> <rant>
> I'm not sure why Solaris has been insisting for ages now in shipping  
> default
> tools that are either old, with less features or downright broken.  
> It's not
> just about sh; other popular tools like awk are also pretty much  
> unusable by
> default under Solaris; one needs to use the POSIX-compliant versions  
> that are
> under /usr/xpg4/bin/.
> </rant>

Most of the common GNU utilities (including gcc) are in the standard  
Solaris install, either via /usr/sfw/ or by using g prefix (e.g. gawk,  
gmake).

--Toby

>
>> Davide: I know you have done some bashishm cleanup already on some  
>> other
>> scripts.  Can you double check that those scripts do not break,  
>> based on
>> this Solaris information?  I was not aware of this limitation in
>> Solaris, so I did not check for such things during the review.  But
>> those patches needs to be double checked now.
>
> As I said, I don't have access to a Solaris box, and I'm not  
> familiar with the
> old Bourne shell.
>
> However, I can certainly check for POSIX compliance, which should be  
> the
> lowest common compatibility level scripts should aim for IMHO.
>
> -- 
> D.
>
> ------------------------------------------------------------------------------
> ThinkGeek and WIRED's GeekDad team up for the Ultimate
> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the
> lucky parental unit.  See the prize list and enter to win:
> http://p.sf.net/sfu/thinkgeek-promo
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


