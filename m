Message-ID: <43C3C0FE.40009@...277...>
From: Alon Bar-Lev <alon.barlev@...277...>
MIME-Version: 1.0
References: <605203017.20060102170037@...450...> <43B9409E.4090903@...277...> <181840658.20060110042715@...450...> <43C37B3E.1090204@...277...> <758887784.20060110165806@...450...>
In-Reply-To: <758887784.20060110165806@...450...>
Subject: [Openvpn-devel] Re: OpenVPN and eToken (on windows).
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Jan 10 06:16:08 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: mts.spb.suxx@...450..., openvpn-devel@lists.sourceforge.net

Hello Andreas,

mts.spb.suxx@...450... wrote:
> ABL> Putting the CA certificate on the smartcard is a potential
> ABL> security issue. Each time you log into the token some one can
> ABL> modify its contents.
> So, I may safely delete my CA's certificate from the token?

Sure! I recommend of doing so.

> I did not see any drawback to having the full chain of trust stored on
> the token...
> Besides, if "they" can modify token's contents - they can
> alter my private key too, can't they?!

They can delete your key, they can replace your key... But 
they cannot issue a new certificate for the new key... The 
combination of trust+private key is the proof that the 
server needs in order to let you in.

So as long as private keys cannot be extracted... and as 
long as the attacker does not have access to the CA private 
key, you are in a good security level.

>>> Is it possible to hide the "ta.key" (that is used for "tls-auth") in
>>> the token as well?
> ABL> Many providers do not support HMAC with key in-side the token...
> eToken PRO is among them - it can either handle RSA-2048 keys or do
> HMAC on hardware...
> 
> ABL> I can store this key as a data object and export it during
> ABL> initialization... But using smartcard as a mass storage device is
> ABL> not a good idea... Especially when this key is common for every
> ABL> users that uses a specific server.
> I thought that the "tls-auth" key values could be something like the result
> of RSA-encoding the "direction" value.
> 
> On UNIXes all this may be non-issue, but on windoze it is really an
> issue to provide security to the files on disks... I'd rather tryed to
> use crypto-hardware to the full extent possible.

Well... I disagree. File protection on Linux and Windows is 
quite similar.

> 
> BTW, having all the set of keys and certs on a token facilitates the
> easier user roaming. That have OpenVPN installed on all workstations
> and let users to plug-in their tokens...

Yes. I understood that this what you try to achieve, but 
roaming and security do not always go on the same track.

I will take you one step farther... Why not put the whole 
openvpn configuration file on the cryptographic device? The 
combination of USB mass storage device and a smartcard is 
the best combination for roaming users.

But there is a drawback... if the user can select any 
openvpn configuration he can alter your network trust and 
bridge it to unauthorized foreign networks...

Best Regards,
Alon Bar-Lev.


