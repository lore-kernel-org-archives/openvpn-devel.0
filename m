MIME-Version: 1.0
In-Reply-To: <5031513E.6010004@...1227...>
References: <CAHFjfK73YDrEUYL0fi7_8pu=v3W3F-sp=Hty3Un1hyJm=T_79g@...278...>
	<20120819100739.GW18296@...1296...>
	<5031513E.6010004@...1227...>
Date: Mon, 20 Aug 2012 08:39:44 +0200
Message-ID: <CAHFjfK57m_e7mErUQby-Du-UMmJS9WrVXS=YRVcyM0VXbR9M8w@...278...>
From: Markus Ferlitsch <m.ferlitsch@...277...>
Subject: Re: [Openvpn-devel] OpenVPN 2.3 alpha - configfile with static
 keyfile does not work!
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I hink you are right. But I also tried to open my ovpn file with
console. Then I didn't get a error but it also not connected - I think
less rights but I opened the console with admin rights.

Now I use TLS for all connections and the 2.3 alpha runs without any
errors on Windows 7 64-bit (OpenVPN 2.2.2 generated such a lot of HMAC
errors with same config-files)

greets



2012/8/19 Arne Schwabe <arne@...1227...>:
> On 19.08.2012 12:07, Gert Doering wrote:
>>
>> Hi,
>>
>> On Sat, Aug 18, 2012 at 11:21:32PM +0200, Markus Ferlitsch wrote:
>>>
>>> Now with OpenvPN 2.3 alpha the TLS configfile works fine (none error in
>>> logfile)
>>> Bu the config-file with only static secret-file doesn't connect - it's
>>> a bug in alpha I think.
>>
>> It's somewhat easier to figure out what's going wrong if we can *see* your
>> config file...
>>
>> My crystal ball is cloudy today.
>
>
> My crystal ball says it is the windows gui which always adds --tls-exit to
> command line options.
>
> Arne

