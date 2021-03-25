References: <65530ded0938659345877e870f49d2ad4b9768ae.camel@...2524...>
 <3852ddc0-a136-3e28-9925-2c597a1cfaca@...2080...>
 <65ed488ce109006ff9527e4836f295907bfe24ea.camel@...2524...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <26399fec-937a-8ccb-1682-105cbd1e968f@...2181...>
Date: Fri, 26 Mar 2021 00:40:34 +0100
MIME-Version: 1.0
In-Reply-To: <65ed488ce109006ff9527e4836f295907bfe24ea.camel@...2524...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] ***UNCHECKED*** Patch: Export NotBefore and
 NotAfter items to the environment in client-connect
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Rolf Fokkens <rolf.fokkens@...2524...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn@...2080..." <openvpn@...2080...>
Cc: Jasper Siero <jasper.siero@...2524...>, Valentin Bajrami <valentin.bajrami@...2524...>

Hi Rolf,

I know this is old....but...

Is this something you'd consider resending based on current master?
Would you also have any chance of testing it again after rebase?

Cheers,

On 17/08/2019 14:12, Rolf Fokkens via Openvpn-devel wrote:
> On Fri, 2019-08-16 at 13:45 +0200, David Sommerseth wrote:
>> This gets a Feature-ACK from me.  This is useful information, and
>> something
>> other users in the community have asked for earlier too.  But there
>> are a few
>> things here before starting to dive into the details.
>>
>> First of all, we want to have patches first into git master, and then
>> we need
>> to discuss in the community if this feature is something we want to
>> backport
>> to the 2.4 release.  After a new release has stabilized (which 2.4
>> has), we
>> are quite reluctant to add new features to those releases.
> 
> I started off by creating a pull request: 
> https://github.com/OpenVPN/openvpn/pull/129
> 
> During creation of the pull request I was pointed to the openvpn-devel
> list, so I attached the patch there too. That one was based on 2.4,
> because that's what we're using and how we're testing (and using) the
> patch.
> 
>> Another thing is that I think it would be valuable to also print this
>> information into the logs as well.  The X509_get_notBefore() value is
>> probably
>> not so important unless that has a value which is in the future.  The
>> X509_get_notAfter() is fine to always log, but would be nice if it
>> would come
>> a M_WARN log entry if it has expired.
>>
>> To achieve this logging feature, setenv_ASN1_TIME() would need to be
>> refactored a bit - possibly by returning a string as well as "is
>> now() after
>> the time stamp?" bool flag.  The "printing" could happen to a
>> gc_arena
>> allocated buffer (which is available in verify_cert_set_env()).  The
>> logging
>> should probably already happen in verify_cert(), which also has its
>> own
>> gc_arena.  There are various alternatives to avoid doing the
>> ASN1_TIME_print()
>> preparations and processing multiple times (for logging and setenv),
>> but I
>> don't have a clear idea right now what could be a reasonable
>> approach.
>>
>> And lastly, this code will break compilation if using
>> ./configure --with-crypto-library=mbedtls ... This should also be
>> improved.
>>
> 
> I updated my pull request based on your feedback. I'm not sure if I
> correcty understood the structure of the software, but I think it's a
> decent attempt.
> 
> - The notAfter information is in the logs now (appended to the "VERIFY
> OK" lines)
> - Warnings are issued if the now is before notBefore of after notAfter
> - openssl specifics are moved to ssl_verify_openssl.c.
> ssl_verify_mbedtls.c has a dummy equivalent which should make openvpn
> both compile and run.
> 
> Attached you'll find the updated patch too.
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

-- 
Antonio Quartulli

