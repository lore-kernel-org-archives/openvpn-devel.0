Message-Id: <53312779-25C8-4857-9A02-C95004329ABF@...1360...>
From: Brian Raderman <brian@...1360...>
In-Reply-To: <4BDC2F8C.1010206@...1114...>
Content-Type: multipart/alternative; boundary=Apple-Mail-2-514772986
Mime-Version: 1.0 (Apple Message framework v936)
Date: Tue, 4 May 2010 22:40:32 -0400
References: <B23F897A-5ADC-4A29-A34B-3BB16C18B4F3@...1360...>
	<4BD7DB78.2010704@...1114...>
	<C5DC4FDD-13FA-45AC-9D17-35BE15E03C1D@...1360...>
	<4BDC2F8C.1010206@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Mac OSX Keychain certificate support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--Apple-Mail-2-514772986
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Hi David,

On May 1, 2010, at 9:41 AM, David Sommerseth wrote:
> Looking good!  You also have dmsg() I believe for debugging as well.
> But then I believe the logging will only be enabled if configured with
> - --enable-debug, iirc.  Anyway, that was just a side note.  If you  
> want
> it like it is now, we don't need to change anything in this regard.

We can leave the logging functionality like it is now.  Again, it is  
not actively being used, it's there just in case.   If it ends up  
being used a lot in future debugging efforts, I may change the calls  
to dmsg().

> Seems good to me.  Have you tried running a patched OpenVPN through
> valgrind?  Just to make sure you don't have any memory leaks.  It's
> important to also check how it reacts when re-negotiating the tunnel
> encryption (--reneg-* arguments can be tweaked to make this happen  
> more
> often).  And also if there are any leaks in error situations.

I hadn't even heard of valgrind until you mentioned it.  I ran the  
certificate code through Mac OSX Instruments to detect memory leaks,  
but that was before I integrated it with OpenVPN and added the  
gc_arena stuff.  I will try running it through Instruments again or  
valgrind when I get a chance.

> Thanks again for job well done!  As I said in the beginning, we're
> getting closer to inclusion now.  I just need to get some  
> confirmations
> from some others in addition who will try out this patch on OSX.   
> What's
> interesting in this next round now is to get confirmation that it
> compiles cleanly and behaves as initially expected.  Then I'd like to
> hear more about if any memory leaks have been found or not.
>
> When they give a positive response on the compilation and usability,
> I'll give you a feature branch in openvpn-testing.git.  And when we  
> feel
> pretty safe that no memory leaks are found, we can look at merging it
> into the allmerged branch.  Does this sound reasonable to you?

Sounds perfectly reasonable.  This is the normal process you go  
through, correct?  My only concern is that we will have difficulty  
finding people to test out this functionality on Mac OSX.  I'm working  
on trying to get the word out to possibly interested parties.   Should  
I have them post their results to this list?

Brian
--Apple-Mail-2-514772986
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webk=
it-line-break: after-white-space; "><div>Hi David,</div><br><div><div>On Ma=
y 1, 2010, at 9:41 AM, David Sommerseth wrote:</div><blockquote type=3D"cit=
e"><div>Looking good! &nbsp;You also have dmsg() I believe for debugging as=
 well.<br>But then I believe the logging will only be enabled if configured=
 with<br>- --enable-debug, iirc. &nbsp;Anyway, that was just a side note. &=
nbsp;If you want<br>it like it is now, we don't need to change anything in =
this regard.<br></div></blockquote><div><br></div><div>We can leave the log=
ging functionality like it is now. &nbsp;Again, it is not actively being us=
ed, it's there just in case. &nbsp; If it ends up being used a lot in futur=
e debugging efforts, I may change the calls to dmsg().</div><br><blockquote=
 type=3D"cite"><div>Seems good to me. &nbsp;Have you tried running a patche=
d OpenVPN through<br>valgrind? &nbsp;Just to make sure you don't have any m=
emory leaks. &nbsp;It's<br>important to also check how it reacts when re-ne=
gotiating the tunnel<br>encryption (--reneg-* arguments can be tweaked to m=
ake this happen more<br>often). &nbsp;And also if there are any leaks in er=
ror situations.<br></div></blockquote><div><br></div><div>I hadn't even hea=
rd of valgrind until you mentioned it. &nbsp;I ran the certificate code thr=
ough Mac OSX Instruments to detect memory leaks, but that was before I inte=
grated it with OpenVPN and added the gc_arena stuff. &nbsp;I will try runni=
ng it through Instruments again or valgrind when I get a chance.</div><div>=
<br></div><blockquote type=3D"cite"><div>Thanks again for job well done! &n=
bsp;As I said in the beginning, we're<br>getting closer to inclusion now. &=
nbsp;I just need to get some confirmations<br>from some others in addition =
who will try out this patch on OSX. &nbsp;What's<br>interesting in this nex=
t round now is to get confirmation that it<br>compiles cleanly and behaves =
as initially expected. &nbsp;Then I'd like to<br>hear more about if any mem=
ory leaks have been found or not.<br><br>When they give a positive response=
 on the compilation and usability,<br>I'll give you a feature branch in ope=
nvpn-testing.git. &nbsp;And when we feel<br>pretty safe that no memory leak=
s are found, we can look at merging it<br>into the allmerged branch. &nbsp;=
Does this sound reasonable to you?<font class=3D"Apple-style-span" color=3D=
"#000000"><font class=3D"Apple-style-span" color=3D"#144FAE"><br></font></f=
ont></div></blockquote><br></div><div>Sounds perfectly reasonable. &nbsp;Th=
is is the normal process you go through, correct? &nbsp;My only concern is =
that we will have difficulty finding people to test out this functionality =
on Mac OSX. &nbsp;I'm working on trying to get the word out to possibly int=
erested parties. &nbsp;&nbsp;Should I have them post their results to this =
list?</div><div><br></div><div>Brian</div></body></html>=

--Apple-Mail-2-514772986--

