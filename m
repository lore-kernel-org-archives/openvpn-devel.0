MIME-Version: 1.0
In-Reply-To: <4F746C32.2070106@...1114...>
References: <4F6D06C5.3030408@...1114...>
	<1332575918-3384-5-git-send-email-alon.barlev@...277...>
	<4F743D70.1090704@...1114...>
	<CAOazyz03pDXURcMLY_RgvEQcXHn-ftj0HHi-nG3H81tX2JadnA@...278...>
	<4F745CE6.5070608@...1114...>
	<CAOazyz01p7zCGvxxh0Un1c63mdF+zcgZSD24Lp8kF=NdpPmfSg@...278...>
	<4F746C32.2070106@...1114...>
Date: Thu, 29 Mar 2012 18:10:24 +0200
Message-ID: <CAOazyz1ygPjKiwp=xpOFHbiquD-=L4sLmdE_OoPBrYYpKSQX1w@...278...>
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

On Thu, Mar 29, 2012 at 4:05 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 29/03/12 15:12, Alon Bar-Lev wrote:
>> On Thu, Mar 29, 2012 at 3:00 PM, David Sommerseth
>> <openvpn.list@...1114...> wrote:
>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>>
>>> On 29/03/12 14:51, Alon Bar-Lev wrote:
>>>> This is not good. Another issue of this MIME magic that should
>>>> be avoided. VC files are CRLF, if we do not commit them this
>>>> way, every time they change we see a complete rewrite.
>>>>
>>>> If you do not want to pull, please do:
>>>>
>>>> find . -name '*.sln' -or -name '*.vcxproj.*' | xargs unix2dos
>>>>
>>>> And commit.
>>>
>>> We had quite some clean-up rounds on CR/LF issues quite a while
>>> ago. After a lot of testing and searching the net, we found out
>>> that keeping the git tree NL only would be an advantage. =C2=A0And
>>> CR/LF issues would be avoided when setting 'git config --global
>>> core.autocrlf true' on Windows boxes. =C2=A0This makes git add CR/LF
>>> when checking out files from the repo automatically, and it will
>>> be stripped out when committing files.
>>>
>>> It's also described here:
>>> <https://community.openvpn.net/openvpn/wiki/GitCrashCourse#Otherneatfea=
turestoenable>
>>>
>>>
>>>
> Can you please double check if this works for you? =C2=A0Then we don't ha=
ve
>>> to bother with the CR/LF issues at all, as it's mostly
>>> automatic.
>>
>> No, this is no good.
>>
>> First global configuration of repository is wrong, as people tend
>> to have different global configurations.
>
> By all means, remove the --global argument. =C2=A0That was an example tak=
en
> from the git crash course, which is aimed at non-experienced people;
> But I'm sorry I didn't remove the --global part in the reply, that
> slipped my mind before sending it. =C2=A0I'm sure you understand the impa=
ct
> of --global far better than first time users, but lets not argue about
> such nit-picking.
>
>> Second, I don't trust the automatic detection of text files.
>
> So far we have had no problems with git in this regards. =C2=A0And as far
> as I can see, the only non-text file have in the git tree now is
> sample/sample-keys/pkcs12.p12.
>
> We also found many places on the net suggesting this approach as
> sensible and recommended approach.
>
>> Third, there are files that must be CRLF no mater if I check it on
>> cygwin, or Linux and use samba share to access the files I still
>> need a valid configuration.
>
> We have not had any complaints about these issues so far, and we did
> change all files to NL about a year ago.

Because up until now you did not have a problem like these microsoft
specific files.

> Until there is a real issue among more git users and/or networked file
> systems and cross-platform developers, then I'm willing to look at
> this. =C2=A0Regarding cygwin, we did also run some tests there too before
> doing our switch, and at that point we didn't hit an issue either.
>
> Lets rather fix real problems.

I am asking to fix real problem!
Believe me that as much as I hate specific configurations, this is required.
For people who use git and for those who are not.

For example...

at your end:
---
./configure
make
make dist
---

at other people end:
---
tar -xf <tarball>
cp -a openvpn* openvpn*.org
cd openvpn*
msvc-dev
<add a file to project>
<save all>
<quit>
cd ..
diff -urNp openvp* openvpn*.org
---

will result in a complete change of all microsoft specific files
because of the new line issue.
is this enough problem?
It will also make the diffs of online files much harder without using git.

I am not trying to make things complex, on the contrary!

Alon.

