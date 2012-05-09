Message-ID: <4FAAF945.8070005@...1227...>
Date: Thu, 10 May 2012 01:09:57 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <4FAAE0A1.2080808@...1227...>
	<CAOazyz2wZ3n-70Pk8W_Z3OE_4_4th1PXWUOZUjOjNXetPkxc7g@...278...>
	<4FAAF152.7070508@...1227...>
	<CAOazyz35bB=q1hpdzjj_aHZ7K_0koT8pcw0csham2AOwMqGrfg@...278...>
In-Reply-To: <CAOazyz35bB=q1hpdzjj_aHZ7K_0koT8pcw0csham2AOwMqGrfg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 10.05.12 00:50, schrieb Alon Bar-Lev:
> On Thu, May 10, 2012 at 1:36 AM, Arne Schwabe <arne@...1227...> wrote:
>> Am 10.05.12 00:09, schrieb Alon Bar-Lev:
>>> Hmmm... the fact that you are not using git, and create separate
>>> branch for the changes makes it very difficult to peak.
>> Sorry. I am new to git and the distributed version systems. I hope this
>> patch is better. I also pushed the changes to
>> https://github.com/schwabe/openvpn/.
> This is good but you need to rebase master... something like:
> $ git checkout android
> $ git rebase master
I will try tommorow.

>> Building with the android build system was easier for me. Openvpn is
>> only build as a shared library but still used as a standalone
>> executable. This has to do with the apk packaging and the android market.
>> Transforming openvpn into a real library turned out to be more difficult
>> because there multiple points in the code where openvpn more or less
>> calls exit to clean up.
> Yes, this is well known, someday we will have to deal with this. Maybe sooner...
> Anyway, I can provide you with a branch that produce both executable
> and library.
That is really interesting for me and the android port.
>> But before discussing the best way of building openvpn on android I
>> would rather like to get input on the other changes.
> Go over the patch, remove all changes that result from plain
> indentation changes, or addition of new lines.
>
> I also don't understand why the log should be special, and you cannot
> just use the management interface as-is.
>
> Please also try to avoid mixing windows code and posix code.
>
> Regarding the tun open, I don't understand why you cannot do this
> before you execute the openvpn, as persisted tun device.
Opening tun works as follows:

- Provide information like ip, routes, dns and domain to Android
- call establish() and get a tun with the specified parameters back.
>
> Bottom line, I don't think there is real need to define a new target
> for android, almost every change you introduce has nothing to do with
> platform specific.
Yes. But I needed some target for android. The target mainly deal with
how interface configuring/routes/ifconfig etc. is handled. With the
Android 4.0 most of these things have to be done differently.
> You should explain clearly why each change is needed... and probably
> split it into own commit.
>>> I suggest you clone the repository at github, create a branch and
>>> order your changes.
>>
>> that would mean to revert all changes, making the changes in small steps
>> and commiting each step? (I am still trying to learn how to work with git)
>>
> Right.
>
> If I understand correctly, if I leave out the library creation, and
> the in-line tap creation, and the management log changes, there are
> only minor changes, which should be explained one-by-one.
Yes. The in line tun creation and the managment interface fd passing are
the important changes of the patchset.

Arne

