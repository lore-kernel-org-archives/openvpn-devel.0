MIME-version: 1.0
Message-id: <4F2191BE.1040402@...384...>
Date: Thu, 26 Jan 2012 18:47:42 +0100
From: David Sommerseth <openvpn.list@...1114...>
References: <1327405130-22393-1-git-send-email-davids@...1347...>
	<CAEsd45R22XK71TEfe8rVCooQ65XsKDTCW_QB9p06VuQmQK0C3g@...278...>
	<20120125221803.GE5060@...1296...>
	<CAEsd45SK+fB=Cgkg2PBNeCyL29t20mi2CPWHymWZsh4Gr0--1w@...278...>
In-reply-to: <CAEsd45SK+fB=Cgkg2PBNeCyL29t20mi2CPWHymWZsh4Gr0--1w@...278...>
Subject: Re: [Openvpn-devel] [PATCH]
	Add	--route-pre-down/OPENVPN_PLUGIN_ROUTE_PREDOWN
	script/plug-in hook
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 25/01/12 23:49, Jonathan K. Bullard wrote:
> On Wed, Jan 25, 2012 at 5:18 PM, Gert Doering <gert@...1296...>
> wrote:
>>> If so, shouldn't patches that change the interface include
>>> appropriate changes to the man page?
>> 
>> ... and so does the patch.  At least my copy of it had a section
>> starting with
> 
> My apologies. I didn't connect that part of the patch with the man
> page.
> 
> However, it looks the patch only adds an entry for the _script_ to
> the "Script Order of Execution" section.
> 
> The description of the _option_ that sets up the script to be 
> executed, the "--route-pre-down" option, that appears in the patch
> for options.c only affects the usage message, not the man page. I
> think that description (or something similar) should also be included
> in the man page (i.e., in openvpn.8).
> 
> Also, it might help to clarify that the script is called before 
> anything at all is done about the disconnection (which I assume is 
> true). In other words, that the route teardown is the first step in 
> the disconnection process. But if that's covered elsewhere I
> apologize (again!).

I'm sorry, but I'm kind of lost in what the issue is.  But that might be
me being blinded by knowing these code paths.

For me it's pretty obvious from the option name what happens at which
time.  I see now that --route-up is actually described twice, while I
only added this simple explanation on the second place (in the "SCRIPTING
AND ENVIRONMENTAL VARIABLES") section.

Having that said, I'm not overly enthusiastic about the current openvpn
man page.  I find it difficult to navigate in, some parts are well
written, some bad, quite some options are lacking - and some of the
documentation is to some degree duplicated.  We did have a request before
the 2.2 release, if some people could go through the documentation and
see if something could be improved and we put up this wiki page [1] with
options which are undocumented.  One guy showed up with patches, which
we're all very grateful to.

Another thing is that developers are not good documentation writers.  We
know the code too well, and what is "bloody obvious" for us might be
completely hidden for normal deadly users.  I don't blame those users, as
I can understand that it might not be obvious when you don't see the
bigger picture, especially from a code perspective.

[1] <https://community.openvpn.net/openvpn/wiki/ManPageUpdatesFor2.2>

> And maybe the copyright notice in openvpn.8 should be updated, too?

Yeah, I didn't care about that, as the man page will (hopefully!) get
more updates before the next release.  Maybe we'll add a complete
copyright patch fixing it more places if needed.

> Sorry to be a pest if I am still off base.

Nah, no feedback is a pest.  Or useless complaints without any useful
information.  What you brought up is pretty much valuable feedback ...
and if it even results in more man page patches coming in, it'll be even
more worth than gold to us :)

So I'm hoping for man page patches now .......... *hint*hint* ;-)


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8hkbwACgkQDC186MBRfrpI5wCeJRpa1JgN7990Bl6DFOMEOUnv
u8QAn1Zdj0Cky7iQWrsXuzBc4MGwV+I+
=ctF+
-----END PGP SIGNATURE-----


