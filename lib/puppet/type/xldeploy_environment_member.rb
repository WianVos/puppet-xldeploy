require 'pathname'

Puppet::Type.newtype(:xldeploy_environment_member) do
  @doc = 'Manage XL Deploy Environment members'


  ensurable do
    defaultvalues
    defaultto :present
  end

  autorequire (:class) do
    'xldeploy'
  end

  autorequire (:xldeploy_ci) do
    self[:members] + [self[:env]] unless self[:members].nil?
  end

  newparam(:id, :namevar => true) do
    desc 'Id, must be unique, not used in XL Deploy'
  end

  newparam(:env) do
    desc 'Id of Environment to add members to'
  end

  newproperty(:members, :array_matching => :all) do
    desc 'Array of member CIs'

    def insync?(is)

      # Comparison of Array's
      # if either the should or the is (which we get from the providers envvars method is not a hash we'll fail
      return false unless is.class == Array and should.class == Array

      # now lets compare the two and see is a modify is needed
      # haven't quite worked out yet what to do with extra values in the is hash
      @should.each do |k|

      # if is[k] is not equal to should[k] the insync? should return false
      return false unless is.include?(k)

      end
      # if none of the values in the array returned false, let's return true
      return true

    end

    def should_to_s(newvalue)
      # Newvalue is an array, but we're only interested in first record.
      newvalue.inspect
    end

    def is_to_s(currentvalue)
      currentvalue.inspect
    end

  end

  newproperty(:dictionaries, :array_matching => :all) do

    desc 'Array of dictionary CIs'

    def insync?(is)

      # Comparison of Array's
      # if either the should or the is (which we get from the providers envvars method is not a hash we'll fail
      return false unless is.class == Array and should.class == Array

      # now lets compare the two and see is a modify is needed
      # haven't quite worked out yet what to do with extra values in the is hash
      @should.each do |k|

        # if is[k] is not equal to should[k] the insync? should return false
        return false unless is.include?(k)

      end
      # if none of the values in the array returned false, let's return true
      return true

    end

    def should_to_s(newvalue)
      # Newvalue is an array, but we're only interested in first record.
      newvalue.inspect
    end

    def is_to_s(currentvalue)
      currentvalue.inspect
    end

  end

  newparam(:rest_url) do
    desc 'The rest url for making changes to XL Deploy'
  end

  newparam(:environment_type) do
    desc 'environment type, default udm.Environment'
    defaultto 'udm.Environment'
  end

  newparam(:ssl) do
    desc 'indicate if ssl should be used'

    defaultto false

    validate do |value|
      fail 'ssl should be true or false' unless value.is_a? TrueClass or FalseClass
    end
  end

  newparam(:verify_ssl) do
    desc 'if set to true the offerd certificate from the server will always be accepted'

    defaultto true

    validate do |value|
      fail 'ssl should be true or false' unless value.is_a? TrueClass or FalseClass
    end

  end
end
