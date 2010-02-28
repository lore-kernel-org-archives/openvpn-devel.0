Message-ID: <4B8A59A2.6050601@...1114...>
Date: Sun, 28 Feb 2010 12:55:14 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B88110D.3020501@...1114...>
	<jwvzl2vr3aw.fsf-monnier+inbox@...1269...>
In-Reply-To: <jwvzl2vr3aw.fsf-monnier+inbox@...1269...>
Subject: Re: [Openvpn-devel] [PATCH] FQDN for routes should expand to all
	IPs (second round)
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
To: Stefan Monnier <monnier@...1268...>
Cc: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 27/02/10 00:27, Stefan Monnier wrote:
>> - From the following review discussion, a few other things needs to be
>> changed and I hope you are willing to look into adopting your patch to
>> those guidelines.  This is also to follow the standards [1] we try to
>> introduce as well.
> 
> Sure, I'd like to get this in the main OpenVPN code, so I'll do what
> it takes.

Cool, thanks a lot!

>> So, to give a summary to what needs to be done:
>> * This feature should be #ifdef'ed, so that it can be disabled for those
>> not wanting this feature.
> 
> AFAIK this is a bug-fix rather than a feature (the current behavior for
> FQDNs mapping to multiple IPs is pretty difficult to justify), so
> I wonder why it requires such #ifdef'ing.

I was doing some considerations back and forth here before starting this
second round.  The issue is that it changes the behaviour quite a lot
from what might be expected from earlier versions (if you're used to the
former behaviour).  And it introduces some new code paths, including a
new function (getaddr_all).  So I would prefer to consider this, at
least for now, as a feature change rather than a bug fix.

By all means, I do see that in your perspective the current default
behaviour is considered as a bug.  But others might have a different
opinion about that.  Those doing the testing will anyway be requested to
enable all these new features, so this feature will be tested and
considered for default enablement later on in the process.  But it will
be easier to track down where a bug was introduced later on, by being
able to disable such bigger functional changes.

>> * MAX_IPS_PER_HOSTNAME should be set via ./configure.  I'd probably
>> recommend that if this value is 0 the feature is not enabled (covers the
>> first point automatically and simplifies ./configure)  If f.ex. only
>> - --enable-resolve-all-ips (probably need a better targeted name) is given
>> without a number, the default should be 20.
> 
> I'll do that.  I do wonder: IIUC setting this to 1 might result in
> reproducing the current (buggy) behavior, so would #ifdef'ing still
> be necessary?

I prefer that having it set to 0 gives the old code path.  The value of
one can be used to have the same behaviour as 0, but with your new code
path.

>> * Implement this patch on top of the frp branch,
> 
> I'm not sure what you mean by the "frp" branch.  Is tht a new branch in
> the Git repository?  

Yes, it's the feature removal branch.  The reason for this is that the
removal of the randomisation is found in this branch.  And here you'll
only find those changes, so a conflict with other fea

>> and make sure you add the possibility to disable the randomisation
>> of resolving.
> 
> Of course, as before I'll just try and keep the "old" code and/or behavior.

Thanks!

>> Would you be willing to do this job?  When these things are covered, I
>> believe the patch has reached a state where it is suitable for inclusion.
> 
> OK, I'll let you know when it's ready for review,

Thanks again, Stefan!  I appreciate your effort into getting this code
ready for inclusion!  (Even though, my requirements might be a big PITA
:))  Anyhow, I only try to follow the guidelines the community have
agreed on, in discussions with James.  Following those guidelines should
hopefully give a higher probability to get the code more easily accepted
into the stable releases.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuKWaIACgkQDC186MBRfrqY6ACfSxy7smYDsqNVnVh7+cUvbGG9
5/UAnREh8N/QTBKOSpD/EEVsEhuMefPq
=XPby
-----END PGP SIGNATURE-----

