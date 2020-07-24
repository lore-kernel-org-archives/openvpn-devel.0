References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-8-arne@...1227...>
 <6fe3f761-ea6e-4b52-36b1-24d20a92a97b@...2080...>
 <145d42e9-1a92-2e60-b494-f49f381ce662@...1227...>
 <c8c30f1b-f378-f2ce-3b9f-390fb8f08582@...2080...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <0d423a5d-544e-dde7-3804-6ae92674766d@...1856...>
Date: Fri, 24 Jul 2020 10:06:31 +0200
MIME-Version: 1.0
In-Reply-To: <c8c30f1b-f378-f2ce-3b9f-390fb8f08582@...2080...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 8/9] Rename ncp-ciphers to data-ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 23-07-2020 18:09, David Sommerseth wrote:
>> This was a deliberate decision. We really want to people to move towards
>> ncp and putting another hurdle with having an option that works better
>> on but gives a warning and a option that does not work on 2.4 does not
>> help here. If we decide that really aliases are a no-go in OpenVPN then
>> I would rather drop data-ciphers and stay with ncp-ciphers forever for
>> this reason.
> 
> Lets take a few steps back try to see a broader picture.
> 
> [..snip..]
> 
> We really need a proper and sane processes to allow the development of OpenVPN
> to have a chance to move on and leave things behind when appropriate, to be
> able to evolve and grow with the future - without being strangled by what
> existed in the far past (meaning: no longer community supported releases).
> Otherwise I do fear for the future of OpenVPN 2.x.
> 
> By having a clear strategy and adhering to a process of feature/option
> management in OpenVPN, we give clearly defined time-window for stability and
> functionality for our users.  This predictability is, in my experience, much
> more important to users than if a specifically named option is supported or not.

Yes, you've made these points clear earlier on IRC. I (and with me Arne
and Gert) just don't agree with you on some of the details, resulting in
a different verdict on this patch.

None of us has trouble with deprecating options. We appreciate the work
you've put into the DeprecatedOptions page, and all of us have sent
and/or acked patched to remove dangerous or obsolete options.

This difference is in how we weigh the pros and cons per option. So I'll
leave the broader picture for now, and summarize why I'm going to ACK
Arne's patch exactly because is *doesn't* print a warning when the old
name is used.

Option name aliases add negligible code complexity and are trivial to
maintain. (Just look at --udp-mtu.) Keeping them in allows users to
write configs that work well and do not produce any warnings on both
older and newer versions. (Printing warnings for harmless things reduces
the value of the other warnings we print.)

Let's focus our time and effort on reducing actual complexity.

-Steffan

