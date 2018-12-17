References: <a3b6dcb2-9c04-3001-797f-fa49fccda790@...1879...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <d4d4f37c-b5a3-4bf3-361c-ff4ae2e9ec8d@...515...>
Date: Mon, 17 Dec 2018 15:29:15 +0200
MIME-Version: 1.0
In-Reply-To: <a3b6dcb2-9c04-3001-797f-fa49fccda790@...1879...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] sbuild_wrapper: state of official openvpn
 repository
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Enno_Gr=c3=b6per?= <groepeen@...1879...>, openvpn-devel@lists.sourceforge.net

Hi,

Il 17/12/18 13:45, Enno Gröper ha scritto:
> Hi Samuli,
> Hi list,
> 
> Some background first:
> I'm currently building new openvpn servers and want to start using the
> official package repositories [0]. I think about using the current
> debian stable or the current Ubuntu LTS (18.04).
> In the past I used to use the distribution supplied openvpn packages,
> but these are usually quite outdated.

Indeed. I generally try to use our own OpenVPN packages for that very
reason.

> Now the questions:
> 
> Am 06.09.18 um 14:25 schrieb Samuli Seppänen:
>> Also, we don't have packages for Ubuntu 18.04 yet.
> 
> May I ask what is stopping this?
> 
> Or let's rephrase it: What kind and/or amount of support is needed to
> get this done?

Somebody needs to do it. I started the work, but my sbuild_wrapper VM
was too old (Debian 7) and it gave me serious issues with the Ubuntu
18.04 shcroot. So I decided to upgrade the builder. Then other work
slowed that project down and I haven't been able to really resume it
yet. Now that my new buildslaves are up there is a small chance I could
work on this again, but then again, handling MSI is at least as high
priority.

> Christian Erhardt wrote:
>> That is exactly what my report here is about, it currently ships very
> old service files.
>> Not from the repo, nor the last ones from Debian/Ubuntu - older than
> both actually
> 
> Is there any progress with this?
> I would prefer using openvpn packages with recent systemd service files.
> What needs to be done to switch to the recent systemd files? Only
> copying? What kind of testing?

There is some_ progress but I have not done anything concrete yet on the
packaging side. The OpenVPN packages provided by Ubuntu for 18.04 seem
to have the openvpn-client@ and openvpn-server@ units. There is still
the old openvpn@ unit in there, but we should move away from it even if
it works. On Fedora 29, for example, openvpn@ is gone already.

David S. wanted us to use our own versions of openvpn-client@ and
openvpn-server@ unit files. I tend to agree, especially as Ubuntu 18.04
already has the same setup (with slightly different unit files), so it
would not require major refactoring of the packaging files/metadata.
With some luck our own unit files would be mostly drop-in replacements.

So what needs to be done:
- Get the packaging files for 18.04 from Ubuntu
- Apply our own unit files on top
- Add 18.04 to sbuild_wrapper
- Ensure that 18.04 builds
- Test the resulting package

All this could be done by anyone who is willing to take a stab at
sbuild_wrapper. I think I might actually setup a Vagrant environment for
this - we have it for openvpn-build already. That would make it easier
for others to setup the sbuild_wrapper environment and provide
contributions to it. I could do this fairly quickly.

If somebody wants and can help out here, I will gladly take the offer.

> The docs at CreatingUnixPackages [1] should be updated.
> It still refers to your fork of openvpn-build [2], but I'm unable to
> find any build scripts or the mentioned "debian/README" there.

Fixed. The CreatingUnixPackages page was truly obsolete.

> Is it correct, that the official builds are made using sbuild_wrapper [3]?
> And then the workflow there is to copy the files from the distribution
> source packages and rebuild with more recent openvpn (with some changes
> to the files of the distribution build env)?

That is correct. More details above.

> 
> [0] https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos
> [1] https://community.openvpn.net/openvpn/wiki/CreatingUnixPackages
> [2] https://github.com/mattock/openvpn-build
> [3] https://github.com/OpenVPN/sbuild_wrapper

> And last, but not least: Thank you very much for all the work you
> already did for us!

Too bad I have not had that much time to work on the packaging recently.
Too much other stuff going on at the same time. Any help with
sbuild_wrapper (OS support or otherwise) would be really nice.
Openvpn-build already has a semi-active community of contributors, but
that is missing for sbuild_wrapper.

Samuli

