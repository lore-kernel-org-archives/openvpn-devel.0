Message-ID: <55526BA8.1060001@...1114...>
Date: Tue, 12 May 2015 23:07:52 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <13470069.462428.1431417550257.JavaMail.root@...1893...>	<5551BE33.2010208@...1227...>	<4001174.479134.1431430060517.JavaMail.root@...1893...>	<CAEsd45ROOw7UBOUTw8T7J_DjiJW-iJ-fo2YyuE5dt9X4VaWyKg@...278...>
	<22326556.492960.1431441687378.JavaMail.root@...1893...>
In-Reply-To: <22326556.492960.1431441687378.JavaMail.root@...1893...>
Subject: Re: [Openvpn-devel] Request peer review of modified OpenVPN client
 software
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Lisa Minogue <lminogue@...1892...>, "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 12/05/15 16:41, Lisa Minogue wrote:
>> "Jonathan K. Bullard" <jkbullard@...277...> wrote:
>>
>> The openvpn_xorpatch which as introduced and discussed in this thread does have some vulnerabilities.
>>
>> Most of the vulnerabilities are null pointer dereferences or other errors when parsing the "scramble" option or are triggered by unlikely values for its parameters. However, one is a potential buffer overflow
>> which can occur while the VPN is active and could potentially be triggered by carefully constructed traffic.
> 
> Thanks Jonathan for your feedback.
> 
> I've a different question for you. What about using stunnel4 with OpenVPN?
> 
> I've seen a situation in which a user opens a stunnel4 connection in Linux (without root) as in the following:
> 
> stunnel filename.ssl
> 
> In a new terminal window, the user, as root, types the following command to connect to an OpenVPN server:
> 
> sudo openvpn filename.ovpn
> 
> I was told the above method achieves the same goal as using the OpenVPN_XOR-patch method, i.e. preventing deep packet inspection carried out by the Great Firewall.
> 
> But does the stunnel4+openvpn combo method have security vulnerabilities? (Last I checked, stunnel4 is available in many Linux distros.)

Hi Lisa,

We honestly know not much about stunnel here.  We care about openvpn.  As Arne
said, any patch can introduce security vulnerabilities.  And that goes for
software as well.  There are no software which is 100% perfect and completely
free for vulnerabilities.  OpenVPN found one not that many months ago which
impacted most versions the project already have released, going over a decade.
 So if there are issues in stunnel, try asking that community instead.  They
know much more about that than what we do here.

Now regarding to why stunnel may work.  Any tunnel which you pipe/proxy
OpenVPN traffic through will modify how the packets leaving your computer.
That means, what once was an OpenVPN which would fit into an OpenVPN signature
detection will not pass that detection - as the traffic doesn't look like
OpenVPN traffic.  The packets have been mangled.

The XOR patch which we've basically rejected so far, modifies how OpenVPN
packets looks like.  Piping the traffic through stunnel will actually encrypt
the OpenVPN packets once more, thus the packets will not look like OpenVPN
packets.  And the same happens if you use obfsproxy from the Tor project,
which also is used to mangle the network packets.

There are many ways to achieve the goal you aim for.  We have generally
recommended obfsproxy, as that's a tool especially designed to do this clever
magic in a very flexible way.  So when a firewall learns the new packet
fingerprint, obfsproxy can easily and quickly be extended with another
mangler.  And that is why we don't want this functionality built into OpenVPN.
 Because it is far harder for OpenVPN to follow what passes through various
"Great Firewalls" (you have more countries doing that than just China).  The
Tor projects have a special interest in making such mangling work as smooth as
possible, with great success.  Hence that has been our primary recommendation.


-- 
kind regards,

David Sommerseth

