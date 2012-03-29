MIME-Version: 1.0
In-Reply-To: <4F745CE6.5070608@...1114...>
References: <4F6D06C5.3030408@...1114...>
	<1332575918-3384-5-git-send-email-alon.barlev@...277...>
	<4F743D70.1090704@...1114...>
	<CAOazyz03pDXURcMLY_RgvEQcXHn-ftj0HHi-nG3H81tX2JadnA@...278...>
	<4F745CE6.5070608@...1114...>
Date: Thu, 29 Mar 2012 15:12:01 +0200
Message-ID: <CAOazyz01p7zCGvxxh0Un1c63mdF+zcgZSD24Lp8kF=NdpPmfSg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 4/6] build: msvc: upgrade to Visual
 Studio 2010 + fixups
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Mar 29, 2012 at 3:00 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 29/03/12 14:51, Alon Bar-Lev wrote:
>> This is not good. Another issue of this MIME magic that should be
>> avoided. VC files are CRLF, if we do not commit them this way,
>> every time they change we see a complete rewrite.
>>
>> If you do not want to pull, please do:
>>
>> find . -name '*.sln' -or -name '*.vcxproj.*' | xargs unix2dos
>>
>> And commit.
>
> We had quite some clean-up rounds on CR/LF issues quite a while ago.
> After a lot of testing and searching the net, we found out that
> keeping the git tree NL only would be an advantage. =C2=A0And CR/LF issues
> would be avoided when setting 'git config --global core.autocrlf true'
> on Windows boxes. =C2=A0This makes git add CR/LF when checking out files
> from the repo automatically, and it will be stripped out when
> committing files.
>
> It's also described here:
> <https://community.openvpn.net/openvpn/wiki/GitCrashCourse#Otherneatfeatu=
restoenable>
>
> Can you please double check if this works for you? =C2=A0Then we don't ha=
ve
> to bother with the CR/LF issues at all, as it's mostly automatic.

No, this is no good.

First global configuration of repository is wrong, as people tend to
have different global configurations.

Second, I don't trust the automatic detection of text files.

Third, there are files that must be CRLF no mater if I check it on
cygwin, or Linux and use samba share to access the files I still need
a valid configuration.

I suggest to remove this global setting and use local setting by
suffix, something like:

.gitattributes
---
*.c eol=3Dlf
*.h eol=3Dlf
*.vc*proj* eol=3Dcrlf
*.sln eol=3Dcrlf
---

Alon.

