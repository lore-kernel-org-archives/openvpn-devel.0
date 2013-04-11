Message-ID: <5166B9BE.80201@...515...>
Date: Thu, 11 Apr 2013 16:25:18 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1346422753-19520-1-git-send-email-arne@...1227...>
	<201304110933.r3B9XwPT011987@...1729...>
	<20130411105202.GA26778@...1296...>
	<5166B459.9020801@...515...>
	<20130411131748.GR569@...1296...>
In-Reply-To: <20130411131748.GR569@...1296...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add the client id (CID) to
 the output of the status command
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

>>> ... unfortunately, it breaks --disable-managemnt builds :-( - good that
>>> we have buildbots, stupid me for not noticing it before ACK-and-push.
>> I wonder if using a "staging" repo would be too much trouble? Buildbots
>> could track it, and only after all builds have succeeded, the changes
>> would be pushed to master.
> You and David explain to me what to do, I do :-)
>
> (Including "how to un-push things pushed to staging if they turn out
> to be non-useful")
>
> gert
>

As long as nobody is actually using the staging repo rewriting history
should not be an issue. Perhaps one could just do

$ git reset --hard HEAD^1
$ git push origin master

and be done with it?

That said, we might not benefit much from a staging repo if we fix the
problems buildbot finds quickly. Sure, the repo might not be 100%
correct / functional all the time, but the impact should be fairly low
compared to pushing out broken releases.

Any opinions, anyone?

Samuli

