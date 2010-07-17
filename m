Message-ID: <4C4185D7.3060406@...1114...>
Date: Sat, 17 Jul 2010 12:28:39 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080209030005010805000902"
Subject: [Openvpn-devel] Merge conflict merging in last changes from SVN
	r6291
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Yonan <jim@...41...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------080209030005010805000902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi James et al.

I'm merging in your latest SVN changes (r6283 to r6306 on BETA21) and a
rather unpleasant merge conflict appeared in socket.c.  See attachment
for the conflict.  The conflict is between git allmerged commit
f0b02a9dfab60b12f and SVN BETA21 r6291.

The issue is that we have a feature deprecation process going on, to
disable random resolving [1].  In that discussion, there were several
concerns if disabling the random resolving would break some users setup,
thus we introduced the rather lengthy FRP path [2].

My concern is that the new getaddr_multi() does actually skip the
complete FRP path for random resolving.  How I do understand SVN r6291,
is that it improves the route setup, where several routes may be added
if more hostnames are resolved.  But in the sense of where getaddr() is
called, it will behave identical when the random resolving is removed.

I have no problems with reverting the disable random resolving patch
(commit 684790552dde04757450 [3]) and go for this new implementation.
But I just need to sure we are aware of this and that we ignore concerns
you raised in the IRC meeting we had February 18 [4].  I've attached the
discussion to this mail as well.


kind regards,

David Sommerseth



[1] <https://community.openvpn.net/openvpn/ticket/4>
[2] <https://community.openvpn.net/openvpn/wiki/FRP>
[3]
<http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=commitdiff;h=684790552dde0475745015a76762ecc5a11eedab>
[4] <http://thread.gmane.org/gmane.network.openvpn.devel/3080>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxBhdcACgkQDC186MBRfrrY3wCfVIRp65y6sewnSvv3uHxx3aMm
UVkAnjARj1oZ/sqIgSZ2hod7PdZcuds9
=aaXi
-----END PGP SIGNATURE-----

--------------080209030005010805000902
Content-Type: text/plain;
 name="socket.c-merge-conflict.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="socket.c-merge-conflict.txt"

diff --cc socket.c
index 1b77418,6f488e9..0000000
--- a/socket.c
+++ b/socket.c
@@@ -221,16 -226,28 +235,41 @@@ getaddr_multi (unsigned int flags
  		++n;
  	      ASSERT (n >= 2);
  
++<<<<<<< HEAD
 +	      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to %d addresses, choosing one by random."
 +                   " [DEPRECATED FEATURE]", hostname, n);
 +
 +	      /* choose address randomly, for basic load-balancing capability */
 +	      ia.s_addr = *(in_addr_t *) (h->h_addr_list[get_random () % n]);
 +
 +#else /* preferred solution */
 +	      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to more than one IP address, will "
 +                   "use the first resolved address", hostname);
 +#endif /* ENABLE_RANDOM_RESOLV */
++=======
+ 	      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to %d addresses",
+ 		   hostname,
+ 		   n);
+ 
+ 	      /* choose address randomly, for basic load-balancing capability */
+ 	      /*ia.s_addr = *(in_addr_t *) (h->h_addr_list[get_random () % n]);*
+ 
+ 	      /* choose first address */
+ 	      ia.s_addr = *(in_addr_t *) (h->h_addr_list[0]);
+ 
+ 	      if (reslist)
+ 		{
+ 		  int i;
+ 		  for (i = 0; i < n && i < SIZE(reslist->data); ++i)
+ 		    {
+ 		      in_addr_t a = *(in_addr_t *) (h->h_addr_list[i]);
+ 		      if (flags & GETADDR_HOST_ORDER)
+ 			a = ntohl(a);
+ 		      reslist->data[i] = a;
+ 		    }
+ 		  reslist->len = i;
+ 		}
++>>>>>>> master
  	    }
  	}
  

--------------080209030005010805000902
Content-Type: text/plain;
 name="excerpt-irc-discussion-feb-18-2010.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="excerpt-irc-discussion-feb-18-2010.txt"

13:36 < dazo> jamesyonan:  I'll throw in the first question .... have you seen the -devel mailing today?  It's been a discussion about "FQDN for routes should expand to all IPs"
13:37 < dazo> jamesyonan:  and the usage of get_random() when returning it in getaddr() .... Karl O. Pinc managed to put words on the things which I do share .... but I'd like to hear your opinion about it as well
13:38  * cron2 doesn't like the way it's done, but given the way the existing code is built, it's hard to do it differently without larger intrusions
13:40 < jamesyonan> So is the idea to not randomize in the client, and let the DNS server control the order?
13:41 < dazo> jamesyonan:  yes, as most DNS servers today either do randomisation itself or round-robin 
13:41 < ecrist> randomizing is silly, since BIND (and some others) do round-robin already
13:42 < dazo> jamesyonan:  but of course, if taking it from the /etc/hosts, it's another issue .... so I'd probably at least recommend making this configurable
13:42 < jamesyonan> but what happens when DNS results are cached by an intermediate server?
13:42 < cron2> lemme test
13:43 < ecrist> I would suggest letting DNS do it's job, however that is.
13:44 < cron2> powerdns_recursor randomizes cached data, unbound does not
13:45 < cron2> bind randomizes
13:46 < dazo> sounds like when DNS is involved, it would be solved by the DNS server .... I remember having configured "simple load-balancing" with BIND-4.x.x as well, using round-robin
13:46 < dazo> (which was a decade ago)
13:47 < jamesyonan> to partially answer my own question, the recent remote-random-hostname option can be used to defeat caching even through DNS servers that ignore TTL
13:47 < cron2> remote-random-hostname?
13:47 < cron2> ah
13:47 < dazo> cron2:  came in 2.1_rc20
13:49 < cron2> it's not in openvpn.8 *complain*
13:49 < dazo> +/*
13:49 < dazo> + * Add a random string to first DNS label of hostname to prevent DNS caching.
13:49 < dazo> + * For example, foo.bar.gov would be modified to <random-chars>.foo.bar.gov.
13:49 < dazo> + * Of course, this requires explicit support in the DNS server.
13:49 < dazo> + */
13:50 < dazo> commit 8e9666d57550 / r4843
13:50 < cron2> I found it in the source, but it's not documented overly well :)
13:51 -!- Kasx [~Kasx@...1321...] has joined ##openvpn-discussion
13:51 -!- mode/##openvpn-discussion [+v Kasx] by ChanServ
13:51 < dazo> jamesyonan:  but that do not really answer if we really should have get_random() in getaddr() ... or did I misunderstand?
13:51 < cron2> does it work?  I've seen this as a major problem actually(!) with people trying to poison DNS caches
13:52 < jamesyonan> well the fact that needs explicit support in the DNS server limits its usage
13:53 < cron2> what is the basic idea behind DNS randomization in OpenVPN?  to be able to specify "remote openvpn.my.corp.net" and have that DNS-balance to 5 OpenVPN server machines?
13:54 < jamesyonan> DNS cache poisoning shouldn't be a risk for OpenVPN due to SSL cert verification
13:54 < dazo> jamesyonan:  yes, that was my impression as well .... okay, I can write a patch for it and mail it to the -devel list 
13:54 < dazo> jamesyonan:  well, but you have those users who chose to not use certificates as well ... do we care about them?
13:54 < jamesyonan> What if we make the randomization behavior depend on the remote-random setting?
13:55 < dazo> that's a good approach
13:55 -!- Kas [~Kasx@...1321...] has quit [Ping timeout: 265 seconds]
13:55 -!- openvpn2009 [~email@...1321...] has quit [Ping timeout: 265 seconds]
13:55  * cron2 still tries to understand the scenarios in which this would be beneficial
13:55 < cron2> dazo: nah.  that way you have more code and still the get_rand() in there
13:55 < dazo> so if remote-random is enabled in config ... then we enable get_random()
13:55 < cron2> all you have won is "more complicated code"
13:56 < cron2> (plus "a function that has no access to the config structure needs to look at a config var")
13:56 < cron2> worst of both worlds
13:56 < jamesyonan> right, but what do you tell people that depend on the old behavior?
13:56 < jamesyonan> isn't it just a trivial if statement?
13:57 < dazo> cron2:  I'm willing to look into this ... iirc, getaddr() isn't called from many places ... and I also vaguely remember that those places mostly had the option struct availabel
13:57 < cron2> it's a trivial if *if* you have access to the config struct, which getaddr() doesn't have
13:57 < cron2> I don't see the benefit
13:57 < dazo> jamesyonan:  I think cron2 is worried about having to rewrite more pieces to get the option struct into getaddr()
13:57 < cron2> if we want randomization, leave it there
13:57 < cron2> if we do not want randomization, kick it
13:57 < cron2> but not both
13:58 < cron2> and document the change in the release notes
13:58 <@mattock> jamesyonan: couldn't we just document the change... 
13:58 <@mattock> cron2: you beat me on this :)
13:58 < jamesyonan> I have no personal attachment to the randomization behavior -- I just want to look out for the possibility that people depend on it
13:59 < cron2> getaddr() is called in about 26 places in the code
13:59 -!- openvpn2009 [~email@...1321...] has joined ##openvpn-discussion
13:59 -!- mode/##openvpn-discussion [+v openvpn2009] by ChanServ
13:59 < dazo> well, the current situation is .... get_random() can potentially mess up DNS servers round-robin/random features ... but might benefit those only depending on static host files 
14:01 <@mattock> is it possible that removing the randomization feature break something which people can't fix by changing configuration somewhere?
14:01 < cron2> I'm still waiting for someone to explain to me which scenarios this is used at all :-)
14:02 < cron2> "remote $host" with multiple addresses could be resolved with multiple "remote" and remote-random
14:02 < dazo> the /etc/hosts approach might not be a big problem ... but some embedded environments might not like that change
14:02 <@mattock> cron2: those will be reported when the feature is removed :)
14:04 < jamesyonan> the OpenVPN project has a long tradition of backward compatibility on even the most minor features :)
14:05 <@mattock> and we all know where that policy lead Microsoft ;)
14:05 < dazo> jamesyonan:  what about that we send out some information on the mailing lists .... "We plan to change this behaviour, will this affect you?"
14:05 <@mattock> dazo: sounds like a good idea
14:05 < dazo> there might even be some customers you can ask the same question as well
14:06 < dazo> and if we don't get any responses, then nobody cares .... and if they complain afterwards .... well, then it's easy to say "but we asked you for feedback"
14:06 <@mattock> and the change should be very visible in the release notes
14:06 < dazo> exactly!
14:06 < cron2> yes
14:07 <@mattock> the change should go through quite a lot of testing in "testing" tree, "stable" SVN tree and in beta and RC phases
14:07 <@mattock> I'd be surprised if somebody did not spot it during that time AND it was important to the users
14:08 < dazo> +1
14:09 < dazo> jamesyonan:  I do share your worries in regards to backward compatibility, I really do .... but if this is a feature nobody really "cares" about, then it is less clever to bloat the code with "useless" code
14:09 < jamesyonan> I don't see what the big deal is in just adding a new GETADDR_x flag for this
14:09 < dazo> oki ... I'll produce a patch and mail it today


--------------080209030005010805000902
Content-Type: application/pgp-signature; name="socket.c-merge-conflict.txt.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="socket.c-merge-conflict.txt.sig"

iEYEABECAAYFAkxBhdcACgkQDC186MBRfrrp4QCcCOjTMTrMMGZSL8UYqRUx0Vq47NgAn0xN
peUaGAhWZTAUufmAT6MVe1+m
--------------080209030005010805000902
Content-Type: application/pgp-signature;
	name="excerpt-irc-discussion-feb-18-2010.txt.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="excerpt-irc-discussion-feb-18-2010.txt.sig"

iEYEABECAAYFAkxBhdcACgkQDC186MBRfrrSOwCfWbexsimTFg+me1SPMRjS6aRKt00AnRKx
X+m3FPXZzrT0t8q0yIYAq22O
--------------080209030005010805000902--

