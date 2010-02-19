Message-ID: <4B7EA05C.5000802@...1114...>
Date: Fri, 19 Feb 2010 15:29:48 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B7E71A5.3020806@...1114...>
	<20100219134650.GR9556@...1296...>
In-Reply-To: <20100219134650.GR9556@...1296...>
Subject: Re: [Openvpn-devel] [IPv6] Merge conflicts in mroute.c (was: Re:
 openvpn-testing tree available)
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
To: Gert Doering <gert@...1296...>
Cc: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 19/02/10 14:46, Gert Doering wrote:
> Hi,
> 
> On Fri, Feb 19, 2010 at 12:10:29PM +0100, David Sommerseth wrote:
>>>> I still need to do some touches for allmerged, as
>>>> we conflict w/ Gert's IPv6 patch on a mroute.c chunk
>>>> IIRC.
>>
>> Even though I know you both have told me that there would be a merge
>> conflict in mroute.c, I decided to put it on the mailing list -
>> hopefully to get an open discussion about it!
> 
> Good :-)
> 
>> I've attached the merge conflict.  It would be great if you could sort
>> this out soon.  Then I'll get both of your trees into the allmerged
>> branch ASAP.  Right now only Gert's code is in the allmerged branch.
> 
> For the allmerged, you could use either one, or none at all(!) :-)
> 
> *I* think you should use mine, of course.  Reason explained below.
> 
> 
>> What I do see might be a challenge (without knowing the code in
>> details), is that JJO's code is using #ifdef, while Gert's code is not.
>>  With a conflict in mroute_addr_print_ex(), which includes an #ifdef I
>> see a potential disaster here.
> 
> The code basically does the same thing "add printing of the IPv6 
> information for a mroute structure containing IPv6 information".
> 
> For OpenVPN to *work*, you need neither, it's just helpful diagnostic 
> output :-) - if the code is unpatched,  it will just do
> 
>          buf_printf (&out, "IPV6");
> 
> for IPv6 mroutes, but not error-abort or fail.  So no danger here.

Sounds good.

> Now, for the different patches.
> 
> My patch "just prints the IPv6 address", using a helper function that
> I added elsewhere (print_in6_addr()).  This function is not available
> in the official tree, so JJO cannot use it for his branch.

Unless he merges in that needed function ;-)

> JJO's patch does more than that, he does DNS lookups to print the
> DNS name for the IPv6 address in question.  Now we enter religious
> territory - *I* think that this is not a good thing.  The existing
> code doesn't do reverse DNS lookups for IPv4 mroute printing, and so 
> the IPv6 code should behave similar to the IPv4 code, and not do DNS 
> either (also, depending on DNS lookup in this place might lead to 
> weird delays in unexpected situations).  But this is partly religious, 
> partly "follow the coding style of the existing code" stuff.
> 
> JJO's patch also adds the port number for MR_WITH_PORT mroutes - which
> is something that never happens for my usage of IPv6 mroutes for 
> IPv6 payload - but that could be easily added to my code.

I have no opinion of what would be good or not in this regard ... I'm
just saying: Make these branches in a state where we can merge them into
allmerged.  I'll leave the battleground to be fought between you two :)

>> Personally, I would like to evaluate Gert's patches to see if they could
>> be #ifdef'ed.  Then both IPv6 branches can both use USE_PF_INET6 to
>> enable or disable the IPv6 support.  I have not studied these patches,
>> so I don't know how doable that is.  And this is my personal opinion, I
>> don't mean to instruct anyone into a direction.  I will let you guys
>> find the proper direction.
> 
> Most changes of my patch could be #ifdef'ed easily - places that just add 
> extra lines of code, extra fields to a structure, and such.  That's the easy
> stuff.
> 
> Other parts are much harder, changes like this one:
> 
>        /* possibly add routes */
>        if (!c->options.route_delay_defined)
> -       do_route (&c->options, c->c1.route_list, c->c1.tuntap, c->plugins, c->c2
> .es); 
> +       do_route (&c->options, c->c1.route_list, c->c1.route_ipv6_list,
> +                 c->c1.tuntap, c->plugins, c->c2.es);
> 
> 
> ... where I had to add extra arguments to a function call.  #ifdef'ing
> that is going to produce really ugly and much harder-to-maintain code
> (because you have to have an #else, with the old call syntax, and 
> future changes of this function call always have to adjust *both* 
> changes).
> 
> 
> I've just re-checked JJO's patch - the #ifdef's in there don't cover
> all the changes either, just the IPv6-specific stuff.  The necessary
> changes to the existing IPv4 infrastructure (data structures etc) are
> not #ifdef'ed - so the #ifdef's here don't serve to deactivate the
> whole patch, but only to disable the actual IPv6 transport functionality.
> 
> 
> Personally, I'm not a big fan of #ifdef'ing changes that affect so many 
> different places of the code (JJO's patch has 109 chunks, my patch 
> has 119 chunks) because it will make the code much harder to read, and
> also harder to test ("how many different combinations of compile-time 
> options need to be enabled to cover all possible code paths?").
> 
> But if that is what it takes to get the code integrated in the main
> source, that's what I'll do.
> 

I know that James prefer #ifdef.  So if you want to have a safer bet
that this code goes into a stable tree, #ifdef will be a plus point for
inclusion.  This is also the main reason why I am advocating #ifdef in
this part if the code.

On the other hand, there are drawbacks to #ifdef in regards to
maintenance, which you've put very well in your answer.  And of course
the possibility of compile and run-time conflicts between #ifdef'ed
code.  Where some #ifdef's either depend on other ones without really
being aware of it, or that it causes other issues during run-time.

I'm fine with whichever path you choose.  But just bear in mind, some
systems might not have IPv6 support - which breaks portability ... and
#ifdef will make it easier for James to accept the patches.

I trust you guys will figure out how to go forward!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt+oFgACgkQDC186MBRfrqXPACgiEOyi9QaH00WWmYD1DPmvlVH
wdQAnizs7ZGvHJc1EwcWaFRLjMkI/uSO
=AqI4
-----END PGP SIGNATURE-----

