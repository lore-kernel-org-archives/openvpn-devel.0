MIME-Version: 1.0
In-Reply-To: <20160525175756.56186-3-openvpn-devel@...2127...>
References: <20160525175756.56186-1-openvpn-devel@...2127...>
	<20160525175756.56186-3-openvpn-devel@...2127...>
From: Steffan Karger <steffan@...1856...>
Date: Thu, 26 May 2016 22:53:33 +0200
Message-ID: <CAA1AbxJ5zmSBzsW7ythLMX1O6KP9C0zF4OcDxHFroqyUoVpGdg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Add a test for auth-pam
	searchandreplace
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Jens <openvpn-devel@...2127...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Sorry for not noticing before, but one last nit:

On Wed, May 25, 2016 at 7:57 PM,  <openvpn-devel@...2127...> wrote:
> +/*  Read 'tosearch', replace all occurences of 'searchfor' with 'replacewith' and return
> + *  a pointer to the NEW string.  Does not modify the input strings.  Will not enter an
> + *  infinite loop with clever 'searchfor' and 'replacewith' strings.
> + *  Daniel Johnson - Progman2000@...1085... / djohnson@...1167...
> + *
> + *  Retuns NULL when
> + *   - any parameter is NULL
> + *   - the worst-case result is to large ( >= SIZE_MAX)
> + */

Now that you're touching these anyway, let's turn these into
doxygen-style comments (/** */).  But maybe Gert/David can do that
when applying the patch, a v2 just for this seems a bit too much.
Also goes for:

> +/*
> + * Given an environmental variable name, search
> + * the envp array for its value, returning it
> + * if found or NULL otherwise.
> + */

and

> +/*
> + * Return the length of a string array
> + */

But for everything else: ACK.  Cool to have the infrastructure for
unit testing in place.  Let's hope others will now thankfully make use
of this.

-Steffan

