MIME-Version: 1.0
References: <CAALvpZTo6VYxcLXtXXyMsUU-n3JRSOJ-62fny7Zfi28WSDYXmA@...278...>
 <b63128cc-14cf-b1a4-684d-4c3fcb291f04@...2181...>
 <20210328085248.GB976@...1296...>
In-Reply-To: <20210328085248.GB976@...1296...>
From: =?UTF-8?B?VMO1aXZvIExlZWRqw6Rydg==?= <toivol@...277...>
Date: Sun, 28 Mar 2021 14:03:37 +0200
Message-ID: <CAALvpZRVrgCb7JZVf=fkgJK73rk8WAHF+Hj_brQO=ww=_yuUMQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Stop using deprecated getpass()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Hi,

Thank you both for the review and feedback.

On Sun, Mar 28, 2021 at 10:52 AM Gert Doering <gert@...1296...> wrote:
>
> On the necessity for the patch, I have mixed feelings - I do not see
> any OS remove getpass() any time soon, as it would break applications...

The specific issue I ran into was getpass() having 8 character limit
on Solaris/illumos.

Still, there is no inherent need to go the way of removing getpass().
There is a workaround for the length limit because Solaris/illumos
have getpassphrase() for which the man page declares "The
getpassphrase() function is identical to getpass(), except that it
reads and returns a string of up to 257 characters in length."

If you don't mind the code being guarded by an #ifdef TARGET_SOLARIS
then a simple alternative patch would look something like this:
-        char *gp = getpass(prompt);
+#ifndef TARGET_SOLARIS
+        char *gp = getpass(prompt); /* On Solaris, returns up to 9 bytes */
+#else
+        char *gp = getpassphrase(prompt); /* Returns up to 257 bytes */
+#endif

or even go one further and do a #define getpass(x) getpassphrase(x)
for TARGET_SOLARIS.

> > > +        (void) tcsetattr(fileno(fp), TCSAFLUSH, &tty_save);
> >
> > We should not need to cast to void - I don't think we have warnings set
> > for non-checked return values.
>
> Actually we should catch errors here and log them.  If tcsetattr() fails,
> the tty will be in a messed-up state - so we want to know that it happened,
> and possibly also the "why".

Right. What you have in mind, would that look like msg(M_ERR,
"...explanation...") or perhaps an M_WARN?

-- 
Toivo

