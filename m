Message-ID: <4F746C32.2070106@...1114...>
Date: Thu, 29 Mar 2012 16:05:38 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F6D06C5.3030408@...1114...>
	<1332575918-3384-5-git-send-email-alon.barlev@...277...>
	<4F743D70.1090704@...1114...>
	<CAOazyz03pDXURcMLY_RgvEQcXHn-ftj0HHi-nG3H81tX2JadnA@...278...>
	<4F745CE6.5070608@...1114...>
	<CAOazyz01p7zCGvxxh0Un1c63mdF+zcgZSD24Lp8kF=NdpPmfSg@...278...>
In-Reply-To: <CAOazyz01p7zCGvxxh0Un1c63mdF+zcgZSD24Lp8kF=NdpPmfSg@...278...>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 29/03/12 15:12, Alon Bar-Lev wrote:
> On Thu, Mar 29, 2012 at 3:00 PM, David Sommerseth 
> <openvpn.list@...1114...> wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> On 29/03/12 14:51, Alon Bar-Lev wrote:
>>> This is not good. Another issue of this MIME magic that should
>>> be avoided. VC files are CRLF, if we do not commit them this
>>> way, every time they change we see a complete rewrite.
>>> 
>>> If you do not want to pull, please do:
>>> 
>>> find . -name '*.sln' -or -name '*.vcxproj.*' | xargs unix2dos
>>> 
>>> And commit.
>> 
>> We had quite some clean-up rounds on CR/LF issues quite a while
>> ago. After a lot of testing and searching the net, we found out
>> that keeping the git tree NL only would be an advantage.  And
>> CR/LF issues would be avoided when setting 'git config --global
>> core.autocrlf true' on Windows boxes.  This makes git add CR/LF
>> when checking out files from the repo automatically, and it will
>> be stripped out when committing files.
>> 
>> It's also described here: 
>> <https://community.openvpn.net/openvpn/wiki/GitCrashCourse#Otherneatfeaturestoenable>
>>
>>
>> 
Can you please double check if this works for you?  Then we don't have
>> to bother with the CR/LF issues at all, as it's mostly
>> automatic.
> 
> No, this is no good.
> 
> First global configuration of repository is wrong, as people tend
> to have different global configurations.

By all means, remove the --global argument.  That was an example taken
from the git crash course, which is aimed at non-experienced people;
But I'm sorry I didn't remove the --global part in the reply, that
slipped my mind before sending it.  I'm sure you understand the impact
of --global far better than first time users, but lets not argue about
such nit-picking.

> Second, I don't trust the automatic detection of text files.

So far we have had no problems with git in this regards.  And as far
as I can see, the only non-text file have in the git tree now is
sample/sample-keys/pkcs12.p12.

We also found many places on the net suggesting this approach as
sensible and recommended approach.

> Third, there are files that must be CRLF no mater if I check it on 
> cygwin, or Linux and use samba share to access the files I still
> need a valid configuration.

We have not had any complaints about these issues so far, and we did
change all files to NL about a year ago.

Until there is a real issue among more git users and/or networked file
systems and cross-platform developers, then I'm willing to look at
this.  Regarding cygwin, we did also run some tests there too before
doing our switch, and at that point we didn't hit an issue either.

Lets rather fix real problems.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk90bC8ACgkQDC186MBRfroFTgCdHZQL+HsEflz1tBwhl0ioa4wF
rkgAoJjE707kh5vtKKhWtTtaWEIqJjLr
=caUc
-----END PGP SIGNATURE-----

