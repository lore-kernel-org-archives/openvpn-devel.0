Message-ID: <4BD56520.9070807@...1114...>
Date: Mon, 26 Apr 2010 12:04:16 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1272210565-9312-1-git-send-email-dave_br@...1278...>
	<4BD4CCA3.5030705@...1114...>
	<201004260956.16533.dave_br@...1278...>
In-Reply-To: <201004260956.16533.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] Serial number export, fixed
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
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 26/04/10 10:56, Davide Brini wrote:
> On Monday 26 Apr 2010 00:13:39 David Sommerseth wrote:
[...snip...]
>>> +# OCSP responder URL (mandatory)
>>> +ocsp_url="http://some.ocsp.server/"
>>> +#ocsp_url="https://some.secure.ocsp.server/"
>>
>> Wouldn't it be better to use a more valid URL?
> 
> And what could it be? I can put in the OCSP URL of some well-known CA, but 
> then if the user is using their own server, that would be meaningless anyway. 
> But I'm open to suggestions.
> 
>> Or at least uncomment both of them 
> 
> Uncommenting both of them makes no sense, as the second assignment overrides 
> the first, so it would be like just uncommenting the second one. They are 
> meant to be mutually incompatible.
> 
>> ... and have a check that this variable is set?  If unset, exit with error.
> 
> Ah well, as I said the script is meant to be a barebone skeleton to 
> demonstrate basic usage. That is by no means the only thing that lacks proper 
> error checking in the script, so if we go down that route there's a lot to be 
> changed. 
> The users are supposed to adapt it to their needs and make it more robust.

Agreed, but from experience with many users ... it's a lot of users who
just take a script and try it out without even looking at the script
itself.  So if the script could fail gracefully giving a hint like
"you've not done as I told you to", some support issues will be avoided.

I've even experienced users where I've told them what to change in some
code before running it on the phone, written it in the mail with the
example code *and* having comments in the code - and still they failed
to modify what they were required to change, calling back and
complaining about it.  Luckily enough, there is not too many of that
kind - but they do exist.  But there are others who actually do try code
without using it, see the error - and then fixing it.  So an error
message would be appropriate if the code is not modified to a "proper"
value - whatever "proper" would be.

>>> +      /* "prints" the serial number onto the BIO and read it back */
>>> +      if ( (i2a_ASN1_INTEGER(bio, X509_get_serialNumber
>>> (ctx->current_cert)) >= 0) && 
>>> +           (( n = BIO_read (bio, serial, sizeof (serial)-1) ) >= 0) ) { 
>>> +        serial[n] = 0;
>>
>> This should really not be needed when you've CLEAR()'ed serial earlier
>> on.  You should trust that BIO_read() do not exceed it's limits or place
>> other garbage after the value.
> 
> Is it really a good idea? You correctly speak of defensiveness later, so why 
> give avay some safety just to avoid an assignment? What harm does it make to 
> leave it in? Doesn't look like an expensive operation to me.
> I'd say actually, for maximum safety, we should set to 0 all the bytes from 
> the n'th all the way to the end of "serial".

Well, you have f.ex. 100 bytes, which are CLEAR()'ed.  Then BIO_read()
puts 50 bytes into this memory space, and returns 50.  Then you set the
end of this section to a value this memory already have via the first
CLEAR() operation.  It's completely redundant.  It's almost like
calculating 2+2 and then validate the answer by doing (1+1)+(1+1).

If BIO_read() returns 50 and writes 60 bytes, that's another issue - and
to be frankly, that's a bug in OpenSSL.  We shouldn't need to be overly
paranoid and validate that OpenSSL does it's job correctly.  We can't
protect OpenSSL from doing stupidities, and such a check will really not
give any improvements - as it might even hide issues which are in
OpenSSL.  I'm of the opinion it's better to get those obviously bugs
(also in "third-party code") surfaced as quick as possible.

Or else you could pull this a lot further and insist on a proper use of
printf(), like:

	int len = strlen(str)
	if( len != printf(str) ) {
		exit(1); /* printf didn't print the complete string */
	}

Do we do that nowadays?  It's for sure the most defensive way of
programming, but it's really expected that printf() does it's job.  But
as I said, this is pulling it to the extremes.

So my point is that we should take care of the data and code which *we*
are in charge of.  If we use a function call from a "third-party code"
which we don't control, we should trust that when the function returns a
value it claims is a non-error situation, we process it as a non-error
situation.  If that turns out to give the wrong result, we can provide
helpful information getting that external code fixed sooner.

>>> +      }
>>> +      else {
>>> +        msg (M_WARN, "CALLBACK: Error reading/writing BIO (for
>>> tls_serial_%d)", ctx->error_depth); 
>>> +        serial[0] = 0;   /* empty
>>> string */
>>
>> Hmmm ... My first thought was that this should not be needed.  On second
>> thought, I realised it really might be needed - as BIO_read() *might*
>> have put some data here before it failed.  So if that can happen, some
>> data which has been parsed badly into memory is still available via the
>> 'serial' string.
>>
>> On the other hand, this might not be that critical, as setenv_str() is
>> pretty safe and will obey the first byte in the string.  So a
>> mem-info-leak is more difficult to manage, as this variable is only
>> available inside this function.
>>
>> But consider to replace this "empty string" with yet another CLEAR(),
>> that's a more defensive approach. 
> 
> Agreed, will do that.
> 
>> This part of the code should hopefulyl not be called much, unless something
>> is really wrong - which means that we can afford to spend a little extra
>> time clearing this region.  Or another approach is to only use setenv_str()
>> using the 'serial' string only on success ... and otherwise setenv_str(opt-
>>> es, envname, "\0")  (might even be that NULL would work as well).
> 
> How would that differ from what I'm doing now? It will still end up being an 
> empty string, but with the downside that we would have two separate calls to 
> setenv_str() to perform what is a single logical action (ie set the 
> environment variable).

The difference is that you do reference data which *might* be corrupt,
if serial contains parts of data - despite your '\0' on the first byte.
 And then you do send this variable further to functions which purpose
is to only give an empty string.

So by setting an empty string explicit, you are very clear in your code
that in this an error situation and that you don't want anything else
than an empty string in this case.  And you don't need to do CLEAR() on
serial in this situation.  That variable will in this case just be
thrown away when the function returns.

>> I'm not convinced about any particular solution here now ... but I'm
>> open for other thoughts about this as well.
> 
> I thought about another option: leaving the environment variable unset (ie, do 
> NOT call setenv_str() at all if there are errors) rather than set it to an 
> empty string.
> The problem with this is that in a shell script is a bit cumbersome to 
> differentitate between an /empty/ variable and an /unset/ variable, and this 
> is because the difference does not usually matter. It definitely doesn't in 
> our case.

I thought about this as well, and thought that this *might* break other
implementations which expects to find the a tls_serial_X variable.  For
shell scripts, you have the issues you mentioned - it's not really
possible to identify empty vs not-set variable.  But you also have
plug-ins written in C, which would use a different approach for looking
for environment variables.

In fact, taking the environment variable completely away in this case
will break the current expected behaviour.  I'm not so confident that we
should do that.  People who already are using C plug-ins might
experience incompatibilities then.

> Another option I thought of is to set the variable to something that could 
> never be a valid serial number, eg "XXXXXXXXX" or something like that. Ugly as 
> hell, if you ask me. And would /still/ require that the user of the variable 
> check what's in it, so checking that it's not empty or checking that it's not 
> "XXXXXXXXX" does not make much difference (and the former allows for more 
> idiomatic code).

A false value would not necessarily solve it better.  So I agree with
you, that an empty string is cleaner and better.  And for C plug-ins,
it's easier and more convenient to validate an empty string vs a false
value.

> Bottom line: I'd still go with the empty variable solution.
> 
>> One last comment is on the coding style.  This patch breaks the coding
>> style (yeah, I admit it - even I've been arrested on this one quite
>> lately).  Please correct that as well ... the current coding style (like
>> it or not) is based on:
>>
>> 	if (boolean expression)
>> 	  {
>> 	     do_something();
>> 	  }
>> 	else
>> 	  {
>> 	     do_something_else();
>> 	  }
>>
>> To keep the code as clean and nicely as possible, we should try to
>> follow the current coding style.  If you don't like the current
>> standard, lets discuss that first :)
> 
> I don't have any problem with whatever standard is in place, so I can surely 
> reformat the code to the preferred style.
> 
> But if I have to say it all, I would say that it doesn't look like that style 
> is applied consistently throughout the code (eg see verify_cert_eku() in 
> ssl.c) although, now that you mention it, I must say that the vast majority of 
> the code does use it, so it makes sense to stick to it.

I'll have a look into verify_cert_eku() and double check that.  And see
whom to blame for that ;-)  But thanks for trying to stay with the
current coding style :)

We should probably have our own "lindent" and "check-patch" scripts as
the Linux kernel have, which could be used before sending patches.  That
could be helpful for everyone.

>> Thanks again, Davide ... I hope I'm not pushing you too hard, but this
>> is a good improvement from the last patch, so this progress is making me
>> happy! :)
> 
> No problem, thanks for the constructive criticism! If you agree, I will 
> implement che changes you suggest in the C code and resend the patch.

Sounds good! :)


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvVZR4ACgkQDC186MBRfrq0/ACghBrf26h0w4QGh17OxPi3fDWc
ypAAn24lmNlVlZ1eznzD6K6jt81rIO3y
=oYJO
-----END PGP SIGNATURE-----

