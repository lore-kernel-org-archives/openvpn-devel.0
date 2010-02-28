From: Stefan Monnier <monnier@...1268...>
Message-ID: <jwvk4txceyv.fsf-monnier+inbox@...1269...>
References: <4B88110D.3020501@...1114...>
	<jwvzl2vr3aw.fsf-monnier+inbox@...1269...>
	<4B8A59A2.6050601@...1114...>
Date: Sun, 28 Feb 2010 15:04:01 -0500
In-Reply-To: <4B8A59A2.6050601@...1114...> (David Sommerseth's message
	of "Sun, 28 Feb 2010 12:55:14 +0100")
MIME-Version: 1.0
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
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: Openvpn-devel@lists.sourceforge.net

> I was doing some considerations back and forth here before starting this
> second round.  The issue is that it changes the behaviour quite a lot
> from what might be expected from earlier versions (if you're used to the
> former behaviour).

I'm at a loss when it comes to try and imagine someone who's used to the
current behavior and bothered by the new behavior.  Really.  How can the
current behavior ever be preferable?  Why would someone ever prefer that
a route would be randomly chosen to either go through the VPN or not.

I haven't heard any such someone raise her voice, and neither have
I heard anyone come up with a scenario where such a someone could exist.

If someone could give at least some vaguely plausible scenario,
that'd help.

> And it introduces some new code paths, including a new function
> (getaddr_all).  So I would prefer to consider this, at least for now,
> as a feature change rather than a bug fix.

OK, so it's a question of code, not of behavior.  That does make sense.

>>> * MAX_IPS_PER_HOSTNAME should be set via ./configure.  I'd probably
>>> recommend that if this value is 0 the feature is not enabled (covers the
>>> first point automatically and simplifies ./configure)  If f.ex. only
>>> - --enable-resolve-all-ips (probably need a better targeted name) is given
>>> without a number, the default should be 20.
>> 
>> I'll do that.  I do wonder: IIUC setting this to 1 might result in
>> reproducing the current (buggy) behavior, so would #ifdef'ing still
>> be necessary?

> I prefer that having it set to 0 gives the old code path.  The value of
> one can be used to have the same behaviour as 0, but with your new code
> path.

That also makes sense then, yes.

>>> * Implement this patch on top of the frp branch,
>> I'm not sure what you mean by the "frp" branch.  Is tht a new branch in
>> the Git repository?
> Yes, it's the feature removal branch.  The reason for this is that the
> removal of the randomisation is found in this branch.  And here you'll
> only find those changes, so a conflict with other fea

I see, that's fine.  IIUC, this will cause a conflict when merging
with some of the IPv6 code.  We'll cross this bridge when we get there.


        Stefan

