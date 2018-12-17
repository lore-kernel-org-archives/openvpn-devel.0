References: <a3b6dcb2-9c04-3001-797f-fa49fccda790@...1879...>
 <d4d4f37c-b5a3-4bf3-361c-ff4ae2e9ec8d@...515...>
 <325823f7-1c48-d86a-fd22-3e8eac2971b6@...1879...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56cdde83-aa02-5b75-beae-629a2d480355@...515...>
Date: Mon, 17 Dec 2018 16:17:57 +0200
MIME-Version: 1.0
In-Reply-To: <325823f7-1c48-d86a-fd22-3e8eac2971b6@...1879...>
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

Il 17/12/18 16:06, Enno Gröper ha scritto:
> Hi,
> 
> Am 17.12.18 um 14:29 schrieb Samuli Seppänen:
>> Somebody needs to do it. I started the work, but my sbuild_wrapper VM
>> was too old (Debian 7) and it gave me serious issues with the Ubuntu
>> 18.04 shcroot. So I decided to upgrade the builder. Then other work
>> slowed that project down and I haven't been able to really resume it
>> yet.
> 
> I'm currently trying with Ubuntu 18.04 as build machine.

That should be perfect. My new build VM is Ubuntu 18.04 as well.

>> I think I might actually setup a Vagrant environment for
>> this - we have it for openvpn-build already. That would make it easier
>> for others to setup the sbuild_wrapper environment and provide
>> contributions to it. I could do this fairly quickly.
> 
> I fully agree with that. Currently I'm trying to follow your README and
> it's not that easy-going.

Ok. I will, as a first step, publish a Vagrant VM in
https://github.com/OpenVPN/openvpn-vagrant that sets up everything
needed to use sbuild_wrapper. I'll do the provisioning so that I can
reuse the same code in production. Launching the VM will require
Virtualbox, at least until somebody is sufficiently motivated to make
the VM run on something else (e.g. via libvirt).

> 
>> Fixed. The CreatingUnixPackages page was truly obsolete.
> 
> Nice. Since I wasn't sure about the state, I didn't want to change
> things prematurely.
> 
> Kind Regards,
> Enno
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 


