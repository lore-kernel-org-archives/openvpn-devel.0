From: Davide Brini <dave_br@...1278...>
Date: Mon, 26 Apr 2010 11:48:38 +0100
References: <1272210565-9312-1-git-send-email-dave_br@...1278...>
	<201004260956.16533.dave_br@...1278...>
	<4BD56520.9070807@...1114...>
In-Reply-To: <4BD56520.9070807@...1114...>
MIME-Version: 1.0
Message-Id: <201004261148.38378.dave_br@...1278...>
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
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On Monday 26 Apr 2010 11:04:16 David Sommerseth wrote:

> >> ... and have a check that this variable is set?  If unset, exit with
> >> error.
> >
> > Ah well, as I said the script is meant to be a barebone skeleton to
> > demonstrate basic usage. That is by no means the only thing that lacks
> > proper error checking in the script, so if we go down that route there's
> > a lot to be changed.
> > The users are supposed to adapt it to their needs and make it more
> > robust.
> 
> Agreed, but from experience with many users ... it's a lot of users who
> just take a script and try it out without even looking at the script
> itself.  So if the script could fail gracefully giving a hint like
> "you've not done as I told you to", some support issues will be avoided.

Ok, that makes sense. I didn't look at it this way, but then I perfectly know 
what you mean, so I'll change it to exit if it detects that something is not 
set properly.

> > Is it really a good idea? You correctly speak of defensiveness later, so
> > why give avay some safety just to avoid an assignment? What harm does it
> > make to leave it in? Doesn't look like an expensive operation to me.
> > I'd say actually, for maximum safety, we should set to 0 all the bytes
> > from the n'th all the way to the end of "serial".
> 
> Well, you have f.ex. 100 bytes, which are CLEAR()'ed.  Then BIO_read()
> puts 50 bytes into this memory space, and returns 50.  Then you set the
> end of this section to a value this memory already have via the first
> CLEAR() operation.  It's completely redundant.  It's almost like
> calculating 2+2 and then validate the answer by doing (1+1)+(1+1).

I'd say that almost everything you do when programming defensively is writing 
apparently "redundant" code, which should never be executed, and all that 
because you don't trust the rest of the code (especially external calls).

Generally speaking, you can't be sure that i2a_ASN1_INTEGER() or BIO_read() do 
not mess with the part of the string that is beyond the actual data they 
write/read. though in this case we can look at their code, and see that they 
indeed don't.

> If BIO_read() returns 50 and writes 60 bytes, that's another issue - and
> to be frankly, that's a bug in OpenSSL.  We shouldn't need to be overly
> paranoid and validate that OpenSSL does it's job correctly.  We can't
> protect OpenSSL from doing stupidities, and such a check will really not
> give any improvements - as it might even hide issues which are in
> OpenSSL.  I'm of the opinion it's better to get those obviously bugs
> (also in "third-party code") surfaced as quick as possible.

Ok, so the thing is "we trust OpenSSL". That's fine.
 
> >> This part of the code should hopefulyl not be called much, unless
> >> something is really wrong - which means that we can afford to spend a
> >> little extra time clearing this region.  Or another approach is to only
> >> use setenv_str() using the 'serial' string only on success ... and
> >> otherwise setenv_str(opt->es, envname, "\0")  (might even be that NULL
> >> would work as well).
> >
> > How would that differ from what I'm doing now? It will still end up being
> > an empty string, but with the downside that we would have two separate
> > calls to setenv_str() to perform what is a single logical action (ie set
> > the environment variable).
> 
> The difference is that you do reference data which *might* be corrupt,
> if serial contains parts of data - despite your '\0' on the first byte.
>  And then you do send this variable further to functions which purpose
> is to only give an empty string.

Not if we CLEAR() it as you suggested, which I'm going to implement.
 
> So by setting an empty string explicit, you are very clear in your code
> that in this an error situation and that you don't want anything else
> than an empty string in this case.  And you don't need to do CLEAR() on
> serial in this situation.  That variable will in this case just be
> thrown away when the function returns.

See above. I don't like having duplicated calls to setenv_str(). I prefer it 
to be called just once in a single place, with a sensible value (that is, the 
actual serial number, or the CLEAR()'ed string if there were errors).
 
> > I thought about another option: leaving the environment variable unset
> > (ie, do NOT call setenv_str() at all if there are errors) rather than set
> > it to an empty string.
> > The problem with this is that in a shell script is a bit cumbersome to
> > differentitate between an /empty/ variable and an /unset/ variable, and
> > this is because the difference does not usually matter. It definitely
> > doesn't in our case.
> 
> I thought about this as well, and thought that this *might* break other
> implementations which expects to find the a tls_serial_X variable.  For
> shell scripts, you have the issues you mentioned - it's not really
> possible to identify empty vs not-set variable.

It is indeed possible, but in this specific case it doesn't make any 
difference since both conditions must be treated the same way (ie, not valid).

> So I agree with you, that an empty string is cleaner and better.  And for C
> plug-ins, it's easier and more convenient to validate an empty string vs a
> false value.

Good! finally we agree on something :)
 
> We should probably have our own "lindent" and "check-patch" scripts as
> the Linux kernel have, which could be used before sending patches.  That
> could be helpful for everyone.

Agreed.

I have another (unrelated) question. The GIT master branch lacks the configure 
script, so how do you go about building it for testing? I vaguely seem to 
remember something about running autoscan plus other tricks, is that the case 
with OpenVPN or are the instructions different? Also, whatever the 
instructions are, I would suggest they be added to the official "developer 
information" page.
Thanks!

-- 
D.

