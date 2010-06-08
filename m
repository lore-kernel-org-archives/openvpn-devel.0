Message-ID: <4C0E6EAB.3040304@...1369...>
Date: Tue, 08 Jun 2010 18:24:11 +0200
From: Martin Mokrejs <mmokrejs@...1369...>
MIME-Version: 1.0
References: <4BF14A59.2000200@...1369...>
In-Reply-To: <4BF14A59.2000200@...1369...>
Subject: Re: [Openvpn-devel] openvpn-2.1.0-r1: easy-rsa tools creates broken
 client CERTs unusable for TLS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,
  I had a look into the original bug report I sent and the summary is this:
at some version openvpn implemented a more strict check for certificate
values and if teh cjeck fails one yields "unsupported certificate purpose"
message.

  I figured out that few more allowed values have to be included in the
certificate so that openVPN does not complain anymore. Basically, the patch
synchronizes the current openVPN behavior with the easy-rsa/ tools.

  Is it clearer now? I attached to the bugreport at Gentoo an older version
of the patch to hopefully help you better with understanding what I tried.
What I believe should happen that somebody documents better what requirements
are for the server/client certifices in openVPN. The patch(es) show what
fields you should describe in docs and some version of the patch be committed
over easy-rsa/openssl.cf as well (or loosen the checks back in openVPN sources).
Martin

> Hi,
> 
> We discussed your bug report in last week's public IRC meeting:
> 
> <http://thread.gmane.org/gmane.network.openvpn.devel/3748>
> 
> In a nutshell, we had difficulties understanding what is required to
> reproduce this bug. Unfortunately the discussion logs were lost so I
> can't be any more specific. Would you like help us understand this issue
> by chatting with our devs on #openvpn-devel@...1334...? Or
> alternatively by sending mail to openvpn-devel mailinglist:
> 
> <http://sourceforge.net/mail/?group_id=48978>
> 
> All the best,
> 
> -- Samuli Seppänen Community Manager OpenVPN Technologies, Inc irc freenode net: mattock 

> Martin Mokrejs wrote:
>> Hi,
>>   I think the easy-rsa/openssl.cnf file should be modified so thet client
>> CERTs would match current openVPN expectations. Please see my bug report
>> at http://bugs.gentoo.org/show_bug.cgi?id=320171 . For convenience, I am
>> attaching the patch here. Did I get it right what has to be done? Would
>> someone fix the HOWTO and FAQ documentation to describe the keyUsage
>> fields and what is actually required for what? There is too many hit
>> in google for "unsupported certificate purpose". ;)

