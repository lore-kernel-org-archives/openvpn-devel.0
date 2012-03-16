Message-ID: <4F633670.1000807@...1114...>
Date: Fri, 16 Mar 2012 13:47:44 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F632647.30603@...515...>
	<20120316114747.GV6615@...1330...>
	<CAOazyz2K4s3V3Yq6W8f9Q2us+vk9ArLT1UX3gKCS4Zxr245o+g@...278...>
In-Reply-To: <CAOazyz2K4s3V3Yq6W8f9Q2us+vk9ArLT1UX3gKCS4Zxr245o+g@...278...>
Subject: Re: [Openvpn-devel] New generic buildsystem: lzo enabled or
 disabled by default?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 16/03/12 13:09, Alon Bar-Lev wrote:
> On Fri, Mar 16, 2012 at 1:47 PM, Alberto Gonzalez Iniesta 
> <agi@...64...> wrote:
>> Since support for LZO is enabled/disabled in runtime configuration,
>> I don't see why disabling it on built time, thus limiting its use
>> later.
> 
> We are talking about the build. Runtime is irrelevant.


Correct.  However, this may indirectly have an impact on end users, if
the packager is not aware of this change.  And as 'enabled' has been the
standard so far, forcing you to explicit disable LZO, this change may
cause some compatibility issues.

The impact on this change mainly hits packagers on the Linux, *BSD and
Solaris packagers platforms - and those who do their own Windows builds.
 The official Windows builds we control and can make sure this feature is
enabled.


But let me redirect this discussion slightly.  What is the *benefit* of
disabling LZO by default?

The argument I see why we should keep it enabled, is that this has been
the default since almost the very beginning - it is kind of expected in
most environments that LZO support is available.

The benefit I see from disabling it, is that less default dependencies
are needed to build it.  But it requires awareness to remember to enable
this feature when building, to stay compliant with what most end-users
expect.


If I could be sure we would not get a rush of "OpenVPN 2.3 doesn't work
anymore!"-complaints, I couldn't really care less.  But as I fear that
many builds *may* break the end-users expectations, I'm more doubtful.
Of course, it all depends on the awareness of the packagers.  But I'm not
really convinced this is the most clever step we do.

Well, I'm torn into both directions, really.  And considering LZO
compression is in most cases a very useful feature, I'm beginning to lean
towards 'enabled as default'.  Unless I hear some really compelling
reasons why that's a bad idea - except of enforcing builders to make sure
lzo libs are installed or they should use --enable-lzo if they want this
feature. After all, the LZO feature has been enabled as default at least
since the OpenVPN 2.0 era.


Anyhow ... the patch which disables it by default, will be included as it
is.  If we decide to go back to 'enabled by default' we'll add that as an
patch on top of Alon's work.  So this is the current situation.



kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9jNm0ACgkQDC186MBRfrru9wCfY0VBkGpuxlkQYgTRm8XUwY0V
/CIAnjDzRMAMZuJUghW/e+KSfGk6JgRO
=l3kb
-----END PGP SIGNATURE-----

