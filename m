From: Davide Brini <dave_br@...1278...>
Date: Mon, 26 Apr 2010 09:56:16 +0100
References: <1272210565-9312-1-git-send-email-dave_br@...1278...>
	<4BD4CCA3.5030705@...1114...>
In-Reply-To: <4BD4CCA3.5030705@...1114...>
MIME-Version: 1.0
Message-Id: <201004260956.16533.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] Serial number export, fixed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On Monday 26 Apr 2010 00:13:39 David Sommerseth wrote:

> Btw!  Very good idea by introducing the OCSP_check.sh example!  And even
> a proper git patch!  I like that :)

Thanks!

> > +# OCSP responder URL (mandatory)
> > +ocsp_url="http://some.ocsp.server/"
> > +#ocsp_url="https://some.secure.ocsp.server/"
> 
> Wouldn't it be better to use a more valid URL?

And what could it be? I can put in the OCSP URL of some well-known CA, but 
then if the user is using their own server, that would be meaningless anyway. 
But I'm open to suggestions.

> Or at least uncomment both of them 

Uncommenting both of them makes no sense, as the second assignment overrides 
the first, so it would be like just uncommenting the second one. They are 
meant to be mutually incompatible.

> ... and have a check that this variable is set?  If unset, exit with error.

Ah well, as I said the script is meant to be a barebone skeleton to 
demonstrate basic usage. That is by no means the only thing that lacks proper 
error checking in the script, so if we go down that route there's a lot to be 
changed. 
The users are supposed to adapt it to their needs and make it more robust.
 
> > +      /* "prints" the serial number onto the BIO and read it back */
> > +      if ( (i2a_ASN1_INTEGER(bio, X509_get_serialNumber
> > (ctx->current_cert)) >= 0) && 
> > +           (( n = BIO_read (bio, serial, sizeof (serial)-1) ) >= 0) ) { 
> > +        serial[n] = 0;
> 
> This should really not be needed when you've CLEAR()'ed serial earlier
> on.  You should trust that BIO_read() do not exceed it's limits or place
> other garbage after the value.

Is it really a good idea? You correctly speak of defensiveness later, so why 
give avay some safety just to avoid an assignment? What harm does it make to 
leave it in? Doesn't look like an expensive operation to me.
I'd say actually, for maximum safety, we should set to 0 all the bytes from 
the n'th all the way to the end of "serial".
 
> > +      }
> > +      else {
> > +        msg (M_WARN, "CALLBACK: Error reading/writing BIO (for
> > tls_serial_%d)", ctx->error_depth); 
> > +        serial[0] = 0;   /* empty
> > string */
> 
> Hmmm ... My first thought was that this should not be needed.  On second
> thought, I realised it really might be needed - as BIO_read() *might*
> have put some data here before it failed.  So if that can happen, some
> data which has been parsed badly into memory is still available via the
> 'serial' string.
> 
> On the other hand, this might not be that critical, as setenv_str() is
> pretty safe and will obey the first byte in the string.  So a
> mem-info-leak is more difficult to manage, as this variable is only
> available inside this function.
> 
> But consider to replace this "empty string" with yet another CLEAR(),
> that's a more defensive approach. 

Agreed, will do that.

> This part of the code should hopefulyl not be called much, unless something
> is really wrong - which means that we can afford to spend a little extra
> time clearing this region.  Or another approach is to only use setenv_str()
> using the 'serial' string only on success ... and otherwise setenv_str(opt-
> >es, envname, "\0")  (might even be that NULL would work as well).

How would that differ from what I'm doing now? It will still end up being an 
empty string, but with the downside that we would have two separate calls to 
setenv_str() to perform what is a single logical action (ie set the 
environment variable).
 
> I'm not convinced about any particular solution here now ... but I'm
> open for other thoughts about this as well.

I thought about another option: leaving the environment variable unset (ie, do 
NOT call setenv_str() at all if there are errors) rather than set it to an 
empty string.
The problem with this is that in a shell script is a bit cumbersome to 
differentitate between an /empty/ variable and an /unset/ variable, and this 
is because the difference does not usually matter. It definitely doesn't in 
our case.

Another option I thought of is to set the variable to something that could 
never be a valid serial number, eg "XXXXXXXXX" or something like that. Ugly as 
hell, if you ask me. And would /still/ require that the user of the variable 
check what's in it, so checking that it's not empty or checking that it's not 
"XXXXXXXXX" does not make much difference (and the former allows for more 
idiomatic code).

Bottom line: I'd still go with the empty variable solution.

> One last comment is on the coding style.  This patch breaks the coding
> style (yeah, I admit it - even I've been arrested on this one quite
> lately).  Please correct that as well ... the current coding style (like
> it or not) is based on:
> 
> 	if (boolean expression)
> 	  {
> 	     do_something();
> 	  }
> 	else
> 	  {
> 	     do_something_else();
> 	  }
> 
> To keep the code as clean and nicely as possible, we should try to
> follow the current coding style.  If you don't like the current
> standard, lets discuss that first :)

I don't have any problem with whatever standard is in place, so I can surely 
reformat the code to the preferred style.

But if I have to say it all, I would say that it doesn't look like that style 
is applied consistently throughout the code (eg see verify_cert_eku() in 
ssl.c) although, now that you mention it, I must say that the vast majority of 
the code does use it, so it makes sense to stick to it.
 
> Thanks again, Davide ... I hope I'm not pushing you too hard, but this
> is a good improvement from the last patch, so this progress is making me
> happy! :)

No problem, thanks for the constructive criticism! If you agree, I will 
implement che changes you suggest in the C code and resend the patch.

-- 
D.

