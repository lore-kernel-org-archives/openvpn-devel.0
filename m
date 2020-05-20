Date: Wed, 20 May 2020 14:31:04 -0700
From: Jeremy Evans <code@...2557...>
Message-ID: <20200520213104.GS23489@...2558...>
References: <20200520183404.54822-1-code@...2557...>
 <20200520193344.GQ1431@...1296...>
MIME-Version: 1.0
In-Reply-To: <20200520193344.GQ1431@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Switch assertion failure to returning
 false
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 05/20 09:33, Gert Doering wrote:
> Hi,
> 
> On Wed, May 20, 2020 at 11:34:04AM -0700, Jeremy Evans wrote:
> > To give some background, we hit this assertion failure, with the
> > following log output:
> 
> This should not happen, asserting out in "normal server use" is bad.  
> 
> (Neither should it ever reach that point without ks->authenticated being 
> true)
> 
> > Tue May 19 15:57:05 2020 username/73.135.141.11:1194 Assertion failed at /path/to/openvpn-2.4.7/src/openvpn/ssl.c:1944 (ks->authenticated)
> 
> Is this with true 2.4.7, or is this something more recent?

This failure was with 2.4.7, but the first time it happened we were
running 2.4.4 (see below)
 
> > @@ -1930,7 +1930,10 @@ tls_session_generate_data_channel_keys(struct tls_session *session)
> >                                            &ks->session_id_remote : &session->session_id;
> >  
> > -    ASSERT(ks->authenticated);
> > +    if (!ks->authenticated) {
> > +        msg(D_TLS_ERRORS, "TLS Error: key_state not authenticated");
> > +        goto cleanup;
> > +    }
> >  
> >      ks->crypto_options.flags = session->opt->crypto_flags;
> >      if (!generate_key_expansion(&ks->crypto_options.key_ctx_bi,
> 
> I'm not sure if that code is correct, though - it will erase key
> material (in cleanup) without actually having generated a session
> key.  So "bad things might happen later".
 
The same behavior would happen if generate_key_expansion fails a few
lines below, so my assumption was it was safe to do so.  However, that's
just an assumption and not even an educated guess.

> But I leave that to Steffan or Arne who understands these intricacies
> better than I do.
> 
> (Just confirmed, the ASSERT() is still like this in master)
> 
> 
> Trying to understand the somewhat twisted maze how ks->authenticated
> is set to true/false leads me to more questions...
> 
>  - are plugins or auth scripts involved on your side?
>  - can you reproduce this, or was this a once-in-a-lifetime crash?

There is a program to implement multifactor authentication as mentioned
in the config (`auth-user-pass-verify "ldap-auth/ldap-auth" via-env`)

This is a statically compiled C program that exits 0 on successful
multifactor authentication and 1 on unsuccessful authentication.

> (reproduceable is better, of course :-) - as this could be a plugin
> or script authentication interfering with changes brought by NCP...)

It's reproducible in the sense that it has happened to us multiple
times.  This is actually the fourth time it has happened.  Previous
times were 2018-04-16 (2.4.4), 2019-09-25 (2.4.7), and 2020-05-13
(2.4.7). Bug #1270 says it also affects 2.4.8.  I haven't tried 2.4.9
yet, but I plan to upgrade the server to use it next month.

It's not reproducible in the sense that I know how to trigger it,
though.

Thanks,
Jeremy

