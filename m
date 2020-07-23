References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-8-arne@...1227...>
 <6fe3f761-ea6e-4b52-36b1-24d20a92a97b@...2080...>
 <145d42e9-1a92-2e60-b494-f49f381ce662@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c8c30f1b-f378-f2ce-3b9f-390fb8f08582@...2080...>
Date: Thu, 23 Jul 2020 18:09:47 +0200
MIME-Version: 1.0
In-Reply-To: <145d42e9-1a92-2e60-b494-f49f381ce662@...1227...>
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
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 23/07/2020 13:36, Arne Schwabe wrote:
> 
>>> +++ b/src/openvpn/options.c
>>> @@ -536,7 +536,7 @@ static const char usage_message[] =
>>>      "--cipher alg    : Encrypt packets with cipher algorithm alg\n"
>>>      "                  (default=%s).\n"
>>>      "                  Set alg=none to disable encryption.\n"
>>> -    "--ncp-ciphers list : List of ciphers that are allowed to be negotiated.\n"
>>> +    "--data-ciphers list : List of ciphers that are allowed to be negotiated.\n"
>>>      "--ncp-disable   : (DEPRECATED) Disable cipher negotiation.\n"
>>>      "--prng alg [nsl] : For PRNG, use digest algorithm alg, and\n"
>>>      "                   nonce_secret_len=nsl.  Set alg=none to disable PRNG.\n"
>>> @@ -7866,7 +7866,8 @@ add_option(struct options *options,
>>>          VERIFY_PERMISSION(OPT_P_NCP|OPT_P_INSTANCE);
>>>          options->ciphername = p[1];
>>>      }
>>> -    else if (streq(p[0], "ncp-ciphers") && p[1] && !p[2])
>>> +    else if ((streq(p[0], "data-ciphers") || streq(p[0], "ncp-ciphers"))
>>> +            && p[1] && !p[2])
>>
>> I do agree to using --data-ciphers instead of --ncp-ciphers, that is far more
>> user-friendly naming of this feature.  NCP is a more technical
>> "under-the-hood" terminology which users don't really need to relate to, where
>> --data-ciphers better explains what it is used for.
>>
>> But I do reject NOT adding a deprecation path for --ncp-ciphers.  We should
>> support --ncp-ciphers for 1-2 major releases, but after that it should be
>> removed.  We have too many options and we certainly should avoid duplicating
>> options with the exact same functionality.

Just let me clarify .... the "1-2 major releases" was too hasty and not well
thought numbers.  Please read my reasoning below for what I really intended to
say.

> This was a deliberate decision. We really want to people to move towards
> ncp and putting another hurdle with having an option that works better
> on but gives a warning and a option that does not work on 2.4 does not
> help here. If we decide that really aliases are a no-go in OpenVPN then
> I would rather drop data-ciphers and stay with ncp-ciphers forever for
> this reason.

Lets take a few steps back try to see a broader picture.

* --ncp-ciphers was introduced in OpenVPN 2.4 as a brand new option.

* Steffan has suggested to add --data-ciphers alias into the next v2.4
  release; to which I agree(!).

* I propose we add a warning whenever --ncp-ciphers used, recommending the
  user to switch to --data-ciphers as soon as possible.

* We keep both --ncp-ciphers *and* --data-ciphers in v2.5 and v2.6.

* When v2.5 is released v2.4 goes into "old stable support" - where both
  alternatives will work.  v2.4 is guaranteed to be supported by the community
  for at least 6 months with full support [0] after v2.5 is released.

* When 2.6 is released, v2.4 goes into "git tree only" support but will have a

  12 month "old stable support" guarantee [0].

* 12 months *after* the v2.6 release is out, we can remove --ncp-ciphers.  But
  since we will not do option changes mid-release easily, it might be natural
  to remove this in OpenVPN 2.7 at earliest.

This means --ncp-ciphers will be supported in 2.4 for the life time of that
release.  And v2.4 is supported for *at least* 18 months after v2.5 is
released.  It also guarantees --ncp-ciphers will first be removed when we
release OpenVPN 2.7.

What would be a problem with such a schedule?  Because I don't understand the
real objection you have to remove options which ends up duplicating other options.


At the same time ... it is also important for me that we try to see this at
from an even bigger perspective than just --ncp-ciphers/--data-ciphers or even
--udp-mtu alone.  Now I'm shifting the discussion to a more generic product
life cycle perspective.

If we skimp through this and just allow whatever option duplications we head
into, just because we're too concerned about various breakages with old
configurations or setups - it will not be the last time we might end up in
such discussions UNLESS we can find a proper and reasonable process for
deprecation (which we in fact already defined for feature deprecation 10 years
ago! [1]).

If we cannot remove options during the whole life time of OpenVPN, we cannot
touch compression options or possibly even deprecate any compression at all -
because we need to support both compression and decompression for the whole
lifetime of OpenVPN.  This also extends into how to ensure proper OpenVPN 3
compatibility as well.

And if we cannot remove any options during the eternal life time of OpenVPN, I
will see no other alternative to being even more critical and rejective to add
new options.  We already have pretty close to 300 options in OpenVPN.  That is
an insane amount - where a typical common OpenVPN setup might need up to 20 of
these options, the rest are for all kinds of special cases.  And we have
several competing solutions which are far simpler in many aspects which new
users might just as well prefer.

Even though I highlight the number of options we have, I do NOT say that we
should swipe them all out and reduce the amount to 50 or so; for some users
they have a _real_ value and provides really useful features.  But I want us
to save the options which do have a REAL value, not because unsupported
OpenVPN versions might break or "10 bytes extra source code" is too heavy to
carry around for an alias option.  I'm arguing for keeping options covering
_REAL_ USE CASE for users.  And no, breaking unsupported OpenVPN releases is
NOT a real use case from my point of view.

But back to the deprecated options  ... If we cannot remove options, we also
need to consider bringing back the --tls-remote option, and --compat-names -
both with the capability to break client configs (in fact, it already did for
several Fedora EPEL users [2]).  The proposal to remove --remote-nopull needs
to be reconsidered, as well as --secret, --max-routes, and possibly even
--ncp-disable.  Maybe even more of these deprecated options needs to be
reconsidered [3].


We really need a proper and sane processes to allow the development of OpenVPN
to have a chance to move on and leave things behind when appropriate, to be
able to evolve and grow with the future - without being strangled by what
existed in the far past (meaning: no longer community supported releases).
Otherwise I do fear for the future of OpenVPN 2.x.

By having a clear strategy and adhering to a process of feature/option
management in OpenVPN, we give clearly defined time-window for stability and
functionality for our users.  This predictability is, in my experience, much
more important to users than if a specifically named option is supported or not.



[0] <https://community.openvpn.net/openvpn/wiki/SupportedVersions>
[1] <https://community.openvpn.net/openvpn/wiki/FRP>
[2]
<https://src.fedoraproject.org/rpms/openvpn/c/c738486b3576df4829c9cef5ccd12c10c4fb7b84?branch=epel7>
[3] <https://community.openvpn.net/openvpn/wiki/DeprecatedOptions>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


