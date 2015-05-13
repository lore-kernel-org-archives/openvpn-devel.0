From: Lisa Minogue <lminogue@...1892...>
Message-ID: <10228092.9779.1431475516449.JavaMail.root@...1893...>
In-Reply-To: <55526BA8.1060001@...1114...>
References: <13470069.462428.1431417550257.JavaMail.root@...1893...>
	<5551BE33.2010208@...1227...>
	<4001174.479134.1431430060517.JavaMail.root@...1893...>
	<CAEsd45ROOw7UBOUTw8T7J_DjiJW-iJ-fo2YyuE5dt9X4VaWyKg@...278...>
	<22326556.492960.1431441687378.JavaMail.root@...1893...>
	<55526BA8.1060001@...1114...>
MIME-Version: 1.0
Date: Wed, 13 May 2015 02:05:16 +0200 (CEST)
Subject: Re: [Openvpn-devel] Request peer review of modified OpenVPN client
 software
Reply-To: Lisa Minogue <lminogue@...1892...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net, "Jonathan K. Bullard" <jkbullard@...277...>

Hi David

> From: David Sommerseth <openvpn.list@...1114...>
> Sent: Tue May 12 23:07:52 CEST 2015
> To: Lisa Minogue <lminogue@...1892...>, Jonathan K. Bullard <jkbullard@...277...>
> Subject: Re: [Openvpn-devel] Request peer review of modified OpenVPN client software
>
>  So if there are issues in stunnel, try asking that community instead.  They know much more about that than what we do here.

Thank you for pointing me in the right direction.

> The XOR patch which we've basically rejected so far, modifies how OpenVPN packets looks like.  Piping the traffic through stunnel will actually encrypt the OpenVPN packets once more, thus the packets will not look like OpenVPN packets.  And the same happens if you use obfsproxy 
> from the Tor project, which also is used to mangle the network packets.

Briefly what are your reasons for rejecting the XOR patch?

> We have generally recommended obfsproxy, as that's a tool especially designed to do this clever magic in a very flexible way.  So when a firewall learns the new packet fingerprint, obfsproxy can easily and quickly be extended with another mangler.  And that is why we don't want this
> functionality built into OpenVPN. Because it is far harder for OpenVPN to follow what passes through various "Great Firewalls" (you have more countries doing that than just China).  The Tor projects have a special interest in making such mangling work as smooth as possible, with great
> success. Hence that has been our primary recommendation.

Thanks once again for your time and effort in helping me understand the advantages of using obfsproxy over XOR patch or stunnel4.

Do OpenVPN developers have an official wiki on how to use obfsproxy with OpenVPN? Or is the article referenced by the following URL--https://community.openvpn.net/openvpn/wiki/TrafficObfuscation--your official guide?

Best regards.

Lisa
-----------------------------------------------------
Mail.be, WebMail and Virtual Office
http://www.mail.be

