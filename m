From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Posible bogus bug report, qualified answer
 required
In-Reply-To: <20041023083241.GB1623@...30...>
Message-ID: <Pine.LNX.4.58.0410231541250.22567@...269...>
References: <20041023083241.GB1623@...30...>
MIME-Version: 1.0
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
Date: Sat Oct 23 14:47:04 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Alberto Gonzalez Iniesta <agi@...64...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>, 277838@...40...

On Sat, 23 Oct 2004, Alberto Gonzalez Iniesta wrote:

> Hello James et al,
> 
> I've just got a bug report [1] at the Debian Bug Tracking System. I'm
> pretty sure it's bogus, but I think it's out of my knowledge to
> classify it as such.
> 
> The bug reporter claims that he can modify almost all of the pre-shared
> key, and the tunnel still gets establish. I'm pretty sure this has
> something to do with only a portion of the pre-shared key being used if
> no direction is specified, but I'd love if anyone could give a more
> thorough explanation (please Cc: 277838@...40... when doing so).

Okay, see my response below.

> 
> Thanks,
> 
> Alberto
> 
> [1] http://bugs.debian.org/277838

*************************

>When I modify the Preshared 2048 bit Static Key on the Initiator Side of 
the
>Tunnel(don't tested the other way) I'm anyhow able to establish the
>Tunnel an send Packets through the Tunnel. I don't understand
>the Key splitting and handling as described below, but I think the Keys
>on both Sides of the Tunnel should be identical for the Tunnel to be
>established.

>I can modify every Char in Line 2,3,4,7,8,9,10,11,12,13,14,15,16 without 
any effect and think this is possible a Bug.

>Bye
>Klaus

No, this is not a bug.  The 2048 bit static key is designed to be large 
enough to allow 512 bit encrypt, decrypt, HMAC send, and HMAC receive keys 
to be extracted from it.

However, this key size is far too large for current conventional OpenVPN 
usage.  OpenVPN uses the 128 bit blowfish cipher by default.  It also uses 
the 160 bit HMAC-SHA1 as a cryptographic signature on packets to protect 
against tampering.  Since you probably didn't specify a key direction 
parameter, the encrypt/decrypt keys for both directions are the same and 
the HMAC keys for both directions are also the same.

That means that OpenVPN is only actually using 128 + 160 = 288 bits out of 
the file -- much less than the 2048 bits which are available.

Below, I will show a sample 2048 bit OpenVPN key, bracketed to show which 
bits are actually used for key material, assuming default crypto settings:

#
# 2048 bit OpenVPN static key
#
-----BEGIN OpenVPN Static key V1-----
 [eac9ae92cd73c5c2d6a2338b5a22263a] -> 128 bits for cipher
4ef4a22326d2a996e0161d25d41150c8
38bebc451ccf8ad19c7d1c7ce09742c3
2047ba60f1d97d47c88f7ab0afafb2ce  
 [f702cb04c7d15ff2606736c1825e830a -> 160 bits for HMAC SHA1
 7e30a796] 4b82825d6767a04b3c8f4583
d4928127262c3a8603776bd6da339f69
dece3bbfee35f1dceb7cbceaef4c6933
2c2cef8ac550ed15213b216b825ab31e
49840f99ff9df3c5f31156439ed6b99c
4fc1bff417d33d77134365e38c9d71cd
e294ba6e65d51703d6d4a629d5fc618e
adddb889b8173ac79b4261328770bbbe
74294bc79e357c82af9ef53f2968be6a
007e6022da0a1a39f2ed5660f94a5926
35d72e5838dd78dd680d91f6edcf6988
-----END OpenVPN Static key V1-----

As you can see, the only lines actually used are 1, 5, and 6.  And of 
course, that matches up perfectly with what you observed.

To verify this, run OpenVPN as follows:

  openvpn --dev null --verb 7 --secret key | grep 'crypt:'

where 'key' is a file containing the key shown above.

Static Encrypt: Cipher 'BF-CBC' initialized with 128 bit key
Static Encrypt: CIPHER KEY: eac9ae92 cd73c5c2 d6a2338b 5a22263a
Static Encrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Static Encrypt: HMAC KEY: f702cb04 c7d15ff2 606736c1 825e830a 7e30a796
Static Decrypt: Cipher 'BF-CBC' initialized with 128 bit key
Static Decrypt: CIPHER KEY: eac9ae92 cd73c5c2 d6a2338b 5a22263a
Static Decrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Static Decrypt: HMAC KEY: f702cb04 c7d15ff2 606736c1 825e830a 7e30a796

Note that the keys which are shown in the OpenVPN output exactly match the 
bracketed section of the key source.

Now if you want to use more of the key material, it is possible to use two 
sets of encrypt/HMAC keys, one for each direction:

  openvpn --dev null --verb 7 --secret key 0 | grep 'crypt:'
  
(Note that the '0' after key chooses one symmetrical direction -- the 
opposite peer would use a '1' to choose the other direction).

Static Encrypt: Cipher 'BF-CBC' initialized with 128 bit key
Static Encrypt: CIPHER KEY: eac9ae92 cd73c5c2 d6a2338b 5a22263a
Static Encrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Static Encrypt: HMAC KEY: f702cb04 c7d15ff2 606736c1 825e830a 7e30a796
Static Decrypt: Cipher 'BF-CBC' initialized with 128 bit key
Static Decrypt: CIPHER KEY: 2c2cef8a c550ed15 213b216b 825ab31e
Static Decrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Static Decrypt: HMAC KEY: adddb889 b8173ac7 9b426132 8770bbbe 74294bc7

Now notice that the Encrypt and Decrypt keys are no longer identical.  The 
encrypt keys are drawing key material from lines 1, 5, and 6 in the key 
file, while the decrypt keys are drawing from lines 9, 13, and 14.

Now the opposite peer will use a key-direction of 1:

  openvpn --dev null --verb 7 --secret key 1 | grep 'crypt:'

Static Encrypt: Cipher 'BF-CBC' initialized with 128 bit key
Static Encrypt: CIPHER KEY: 2c2cef8a c550ed15 213b216b 825ab31e
Static Encrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Static Encrypt: HMAC KEY: adddb889 b8173ac7 9b426132 8770bbbe 74294bc7
Static Decrypt: Cipher 'BF-CBC' initialized with 128 bit key
Static Decrypt: CIPHER KEY: eac9ae92 cd73c5c2 d6a2338b 5a22263a
Static Decrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Static Decrypt: HMAC KEY: f702cb04 c7d15ff2 606736c1 825e830a 7e30a796

Notice how the Encrypt and Decrypt keys are swapped, in relation to the 
key-direction 1 example.

So you might ask why is the OpenVPN static key file so large, if such a 
small percentage of the bits are currently used?  The answer is to 
accomodate future ciphers and HMAC hashes which use large keys.  Changing 
a file format is obviously problematic from a compatibility perspective, 
so 2048 bits were chosen so that two sets of 512-bit encrypt and HMAC keys 
could be derived for two separate key directions.

James


